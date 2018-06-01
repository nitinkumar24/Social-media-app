class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]
    validates :name, presence: true
    validates :username, presence: true,length: {minimum: 4, maximum: 15}, format: { with: /\A[a-zA-Z0-9_]+\z/ ,message: 'should only caontain a-z,A-Z,0-9 or _'}
    validates_uniqueness_of :username

    has_many :posts, dependent: :destroy
    has_many :user_modes, dependent: :destroy
    has_many :notifications, dependent: :destroy
    has_many :friendrequests1, :class_name => "Friendrequest", :foreign_key => "sender_id",dependent: :destroy
    has_many :friendrequests2, :class_name => "Friendrequest", :foreign_key => "receiver_id",dependent: :destroy
    has_many :follow_mappings1, :class_name => "FollowMapping", :foreign_key => "follower_id",dependent: :destroy
    has_many :follow_mappings2, :class_name => "FollowMapping", :foreign_key => "followee_id", dependent: :destroy




    has_attached_file :avatar, :styles => { :thumb => '200x200>', :original => '700x700>'}, :default_url => "https://png.icons8.com/dusk/100/000000/gender-neutral-user.png"
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


    def authorized(object)          #check if user can like dislikie or comment
        type = object.class.name
        if type == "Post"
            if object.flavour == "confession"
                return object.mode == @current_mode
            elsif object.flavour == "feed"
                if object.user_id == id or follow_relation(object.user_id) == UserRelations::FOLLOWED
                    puts "in feed"
                    return true
                end
            elsif object.flavour == "meme"
                if object.mode == "open"
                    if object.user_id == id or follow_relation(object.user_id) == UserRelations::FOLLOWED
                        return true
                    end
                else
                    return object.mode == @current_mode
                end
            end
        end

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
        id
    end

    def homefeed

        users = followee_ids
        users << id
         if followee_ids.count > 5
            Post.includes(:user, :likes, :dislikes, comments: [:replies]).where(user_id: users, flavour: "feed", mode: @current_mode).order(created_at: :desc)
         else
             # Post.where(user_id: users, flavour: "feed", mode: @current_mode).order(created_at: :desc).as_json(include: :user)
            Post.where(user_id: users, flavour: "feed", mode: @current_mode,anonymous:false).order(created_at: :desc)
        end
    end

    def memefeed
        users = followee_ids
        users << id
        Post.includes(:user, :likes, :dislikes, comments: [:replies]).where(user_id: users, flavour: "meme", mode: @current_mode).order(created_at: :desc)
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
        puts "lol"
        puts @current_mode
        puts "loda"
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

    # @current_mode har user object k lie alag hoga.
    # Agr @user.follwers type koi method call kr rhe hn to @current_mode nil hoga

    def followers(user_id, mode)
        puts "in followers"
        puts self.id
        puts user_id
        FollowMapping.where(:followee_id => user_id,:mode => mode)
    end

    def followee(user_id, mode)
        puts "in followee"
        puts user_id
        FollowMapping.where(:follower_id => user_id,:mode => mode)
    end

    def friend_requests(user_id, mode)
        puts "in followers"
        puts self.id
        puts user_id
        Friendrequest.where(:receiver_id => user_id,:mode => mode)
    end

    def is_following user_id
        puts "in is_following"
        FollowMapping.where(:followee_id => user_id, :follower_id => self.id,:mode => @current_mode).length > 0
    end

    def mention(query)
        puts @current_mode
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

            if data.image? and data.image != "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"
                puts data.image
                user.avatar = URI.parse(data.image)
                user.avatar_file_name = "photo"
                user.avatar_content_type = "image/jpeg"
            end


        end
        user
    end

end
