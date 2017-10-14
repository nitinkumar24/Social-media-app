class NotificationsController < ApplicationController
  def show
    @notifications=Notification.where(:recipient_id => current_user.id).reverse
  end


end
