class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]
    validates :name, presence: true
    # validates_format_of :email, with: /\.edu/, message: 'Your email should contain .edu '
    has_many :posts, dependent: :destroy
    has_many :user_modes, dependent: :destroy

    has_attached_file :avatar, :styles => { :thumb => '50x50', :medium => '1000x1000', :small => '500x500'}, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    crop_attached_file :avatar
    devise :omniauthable, :omniauth_providers => [:google_oauth2]



    searchkick word_start: [:name,:username]

    #searchkick for searching the user
    def self.aggs_search(params,uisc_ids)
        query = params[:query].presence || '*'
        conditions = {}
        conditions[:id] = uisc_ids
        conditions[:sex] = params[:gender] if params[:gender].present?
        conditions[:department] = params[:department] if params[:department].present?
        users = User.search query,fields:[:name], where: conditions , match: :word_start
        users
    end

    def avatar_geometry(style = :original)
        @geometry ||= {}
        @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
    end


    # DONT NEED PASSWORD FOR UPDATING PROFILE
    def update_with_password(params, *options)
        current_password = params.delete(:current_password)

        if params[:password].blank?
            params.delete(:password)
            params.delete(:password_confirmation) if params[:password_confirmation].blank?
        end

        result = if params[:password].blank? || valid_password?(current_password)
                     update_attributes(params, *options)
                 else
                     self.assign_attributes(params, *options)
                     self.valid?
                     self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
                     false
                 end

        clean_up_passwords
        result
    end

    def to_param  # overridden
        username
    end

    def feed
        users = followee_ids
        users << id
        Post.includes(:user, :likes, :dislikes, :comments).where(user_id: users, flavour: "feed").order(created_at: :desc)
    end


    def follow_relation user_id
        return UserRelations::SELF if id == user_id
        if FollowMapping.where(:followee_id => user_id, :follower_id => id,:mode => @current_mode).length > 0
            UserRelations::FOLLOWED
        elsif Friendrequest.where(:receiver_id => user_id, :sender_id => id,:mode => @current_mode).length>0
            return UserRelations::SENT
        else
            puts UserRelations::NOTFOLLOWED
            UserRelations::NOTFOLLOWED
        end

    end

    def can_follow user_id
        follow_relation(user_id) == UserRelations::NOTFOLLOWED
    end

    def can_un_follow user_id
        follow_relation(user_id) == UserRelations::FOLLOWED
    end

    def can_delete_request user_id
        follow_relation(user_id) ==UserRelations::SENT
    end

    def followee_ids
        FollowMapping.where(follower_id: id,:mode => @current_mode).pluck(:followee_id)
    end

    def follower_ids
        FollowMapping.where(followee_id: id, :mode => @current_mode).pluck(:follower_id)
    end

    class UserRelations
        SELF = 0
        FOLLOWED = 1
        NOTFOLLOWED = 2
        SENT =3
    end

    def followers user_id
        count_followers=FollowMapping.where(:followee_id => user_id,:mode => @current_mode).length
    end

    def followee user_id
        count_followee=FollowMapping.where(:follower_id => user_id,:mode => @current_mode).length
    end

    def is_following user_id
        FollowMapping.where(:followee_id => user_id, :follower_id => self.id,:mode => @current_mode).length > 0
    end

    def mention(query)
        return User.none unless query.present?
        # conditions = {}
        # conditions[:id] = follower_ids
        # users = User.search query,fields:[:username], where: conditions               #will use after partial search in es
        # You should bring this user query into your User model as a scope

        username_like_users = User.limit(10).where('username like ? OR name LIKE ?',"#{query}%","#{query}%").pluck(:id)
        ids =  username_like_users & follower_ids
        puts ids
        users = User.where(id: ids)                                                     #this need to be removed bacuse extra query
        users.map do |user|
            puts user.name
            {  name: user.username,real_name: user.name, image: user.avatar(:thumb)}     #beacuse at.who js is responding to name only thats why sending username in name field
        end
    end

    def generate_access_token
        generated = SecureRandom.hex

        until User.where(access_token: generated).first.nil?
            generated = SecureRandom.hex
        end
        self.access_token = generated
        save!
    end


    # GMAIL LOGIN
    def self.from_omniauth(access_token)
        data = access_token.info
        puts data
        user = User.where(:email => data["email"]).first
        unless user
            password = Devise.friendly_token[0,20]
            user = User.new
            user.name = data["name"]
            user.email =  data["email"]
            username = data["email"].split("@").first
            tested_username =username.gsub!(/[^0-9A-Za-z]/, '')

            if tested_username.nil?
                user.username = username
            else
                user.username = tested_username
            end

            user.password = password
            user.password_confirmation =  password
            user.skip_confirmation!
            user.save

            open_emails = ["gmail.com","outlook.com","yahoo.com","hotmail.com"]
            user_mail_domain = user.email.split("@").last

            if open_emails.include? user_mail_domain
                UserMode.create(user_id: user.id, mode: "open")
            else
                UserMode.create(user_id: user.id, mode: user_mail_domain)
            end

            if data.image?
                user.avatar = URI.parse(data.image)
                user.avatar_file_name = "photo"
                user.avatar_content_type = "image/jpeg"
            end

        end
        user
    end

end
