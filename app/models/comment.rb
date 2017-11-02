class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: {maximum: 400}

  def liked_by user_id
    Like.where(comment_id: id,user_id: user_id).length>0
  end

  def like_string user_id
      if liked_by user_id
        return "unlike"
      else
        return "like"
    end
  end

  def disliked_by user_id
    Dislike.where(comment_id: id,user_id: user_id).length>0
  end

  def dislike_string user_id
    if disliked_by user_id
      return "undislike"
    else
      return "dislike"
    end
  end
end
