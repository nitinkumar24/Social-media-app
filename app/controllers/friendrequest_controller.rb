class FriendrequestController < ApplicationController

  def create
    followee_id = params[:followee_id]
    return redirect_to '/users'
  end

end
