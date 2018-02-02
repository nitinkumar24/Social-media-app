class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable

    validates :name, presence: true
    # validates_format_of :email, with: /\.edu/, message: 'Your email should contain .edu '
    has_many :posts, dependent: :destroy


    has_attached_file :avatar, :styles => { :thumb => '50x50', :medium => '1000x1000', :small => '500x500'}, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    crop_attached_file :avatar



    def avatar_geometry(style = :original)
        @geometry ||= {}
        @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
    end

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

    def to_param
        [id, name.parameterize].join("-")
    end

    def self.search(search)

        if search
            where('name LIKE ?', "%#{search}%" )
        else
            all
        end
    end

    def feed
        users = followee_ids
        users << id
        Post.includes(:user, :likes).where(user_id: users, flavour: "feed").order(created_at: :desc)
    end


    def follow_relation user_id
        return UserRelations::SELF if id == user_id
        if FollowMapping.where(:followee_id => user_id, :follower_id => id).length > 0
            return UserRelations::FOLLOWED
        elsif Friendrequest.where(:receiver_id => user_id, :sender_id => id).length>0
            return UserRelations::SENT
        else
            puts UserRelations::NOTFOLLOWED
            return UserRelations::NOTFOLLOWED
        end

    end

    def can_follow user_id
        return follow_relation(user_id) == UserRelations::NOTFOLLOWED
    end

    def can_un_follow user_id
        return follow_relation(user_id) == UserRelations::FOLLOWED
    end

    def can_delete_request user_id

        return  follow_relation(user_id) ==UserRelations::SENT
    end

    def followee_ids
        FollowMapping.where(follower_id: id).pluck(:followee_id)
    end


    class UserRelations
        SELF = 0
        FOLLOWED = 1
        NOTFOLLOWED = 2
        SENT =3
    end

    def followers user_id
        count_followers=FollowMapping.where(:followee_id => user_id).length
    end

    def followee user_id
        count_followee=FollowMapping.where(:follower_id => user_id).length
    end

    def is_following user_id
        FollowMapping.where(:followee_id => user_id, :follower_id => self.id).length > 0
    end

    def generate_access_token
        generated = SecureRandom.hex

        until User.where(access_token: generated).first.nil?
            generated = SecureRandom.hex
        end
        self.access_token = generated
        save!
    end


end
