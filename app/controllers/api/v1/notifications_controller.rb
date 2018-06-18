module Api
    module V1
        class NotificationsController <::ApiController

            def show
                Notification.where(:recipient_id => current_user.id,mode: @current_mode,seen: false).update_all(seen: true)
                data=Notification.where(:recipient_id => current_user.id,mode: @current_mode)
                                       .order(created_at: :desc).as_json(include: :user)
                response_data(data,"Notifications",200)
            end
        end

    end
end
