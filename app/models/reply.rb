class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  after_create :add_mentions

  def add_mentions
      Mention.create_from_text(self)
  end

  def can_delete user
      self.user_id == user.id or self.comment.user_id == user.id or self.comment.post.user_id == user.id
  end

  def can_update user
      self.user_id == user.id
  end
end
