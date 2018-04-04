class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    after_create :create_notification
    after_destroy :delete_notification

    def create_notification
        puts "testing"
        post_owner_id = self.post.user_id
        current_user= self.user
        unless post_owner_id == current_user.id
            link_to_actor_profile = current_user.profile_link current_user                     #actor is current_user
            Notification.create(user_id: current_user.id, recipient_id: post_owner_id,
                                message: link_to_actor_profile + ' liked your post',
                                noti_type: 'post-like',
                                noti_type_id: self.id,
                                mode:current_user.current_mode)
            recipient_user = self.post.user
            recipient_user.new_notifications += 1
            recipient_user.save

        end
        puts self.id
    end

    def delete_notification
        puts "delte"
        post_owner_id = self.post.user_id
        current_user= self.user
        unless post_owner_id == current_user.id
            notification = Notification.where(noti_type_id: self.id,noti_type: "post-like").first
            notification.destroy!
        end
        puts self.id
    end

end
