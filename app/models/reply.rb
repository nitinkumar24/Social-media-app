class Reply < ApplicationRecord
    belongs_to :user
    belongs_to :comment
    has_paper_trail
    after_create :add_mentions
    after_create :create_notification
    after_destroy :delete_notification

    def create_notification
        puts "testing"
        comment_owner_id = self.comment.user_id
        post_owner_id = self.comment.post.user_id
        current_user= self.user
        link_to_actor_profile = current_user.profile_link current_user                     #actor is current_user

        unless comment_owner_id == current_user.id
            Notification.create(user_id: current_user.id, recipient_id: comment_owner_id,
                                message: current_user.name.capitalize + " replied on your comment",
                                noti_type: "comment-reply",
                                noti_type_id: self.id,
                                mode:current_user.current_mode)
            recipient_user = self.comment.user
            recipient_user.new_notifications += 1
            recipient_user.save


        end

        unless  post_owner_id == current_user.id or comment_owner_id == post_owner_id
            Notification.create(user_id: current_user.id, recipient_id: post_owner_id,
                                message: current_user.name.capitalize + " replied on a comment of your post",
                                noti_type: "comment-reply",
                                noti_type_id: self.id,
                                mode:current_user.current_mode)
            recipient_user = self.comment.post.user
            recipient_user.new_notifications += 1
            recipient_user.save
        end

    end


    def delete_notification
        comment_owner_id = self.comment.user_id
        post_owner_id = self.comment.post.user_id
        current_user= self.user

        unless comment_owner_id == current_user.id
            notification1 = Notification.where(noti_type_id: self.id,recipient_id: comment_owner_id,noti_type: "comment-reply").first
            if notification1
                notification1.destroy!
            end
        end

        unless  post_owner_id == current_user.id or comment_owner_id == post_owner_id
            notification2 = Notification.where(noti_type_id: self.id,recipient_id: post_owner_id,noti_type: "comment-reply").first
            if notification2
                notification2.destroy!
            end
        end


        puts "delte"
    end

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
