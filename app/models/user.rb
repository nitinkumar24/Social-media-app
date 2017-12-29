class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable, :confirmable

	validates :name, presence: true
	validates_format_of :email, with: /\.edu/, message: 'Your email should contain .edu '


	has_attached_file :avatar, :styles => { :medium => "1000x00>", :thumb => "40x40#" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/




	def feed
		Post.all.order(created_at: :desc).page(params[:page])
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

	def isFollowing

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
