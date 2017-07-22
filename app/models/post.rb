class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :dislikes
  validates :content, presence: true, length: {maximum: 140}



  def liked_by user_id
  	Like.where(post_id: id, user_id: user_id).length > 0
  end


  def like_string user_id
  	if liked_by user_id
  		return "UnLike"
  	else
  		return "Like"
  	end

  end


  def disliked_by user_id
    Dislike.where(post_id: id, user_id: user_id).length > 0
  end


  def dislike_string user_id
    if disliked_by user_id
      return "UnDisLike"
    else
      return "DisLike"
    end

  end
end
