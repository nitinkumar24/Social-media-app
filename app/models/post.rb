class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: {maximum: 400}
  has_attached_file :avatar, styles: { medium: "1920x1080>", thumb: "420x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  def liked_by user_id
  	Like.where(post_id: id, user_id: user_id).length > 0
  end


  def like_string user_id
  	if liked_by user_id
  		return "Like"
  	else
  		return "Unlike"
  	end

  end


  def disliked_by user_id
    Dislike.where(post_id: id, user_id: user_id).length > 0
  end


  def dislike_string user_id
    if disliked_by user_id
      return "DisLike"
    else
      return "UnDisLike"
    end

  end


end
