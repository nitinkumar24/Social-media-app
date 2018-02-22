class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, dependent: :destroy
  validates :content, presence: true, length: {maximum: 400}
  after_create :add_mentions
  after_create :create_notification
  after_destroy :delete_notification

  def create_notification
      puts "testing"
      post_owner_id = self.post.user_id
      current_user= self.user
      unless post_owner_id == current_user.id
          link_to_actor_profile = current_user.profile_link current_user
          Notification.create(user_id: current_user.id, recipient_id: post_owner_id,
                              message: link_to_actor_profile + " commented on your post",
                              noti_type: "post-comment",
                              noti_type_id: self.id,
                              mode:current_user.current_mode)
      end
      puts self.id
  end

  def delete_notification
      puts "delte"
      post_owner_id = self.post.user_id
      current_user= self.user
      unless post_owner_id == current_user.id
          notification = Notification.where(noti_type_id: self.id,noti_type: "post-comment").first
          notification.destroy!
      end
      puts self.id
  end

  def add_mentions
      Mention.create_from_text(self)
  end

  def can_delete user
      self.user_id == user.id or self.post.user_id == user.id
  end

    def can_update user
        self.user_id == user.id
    end
end