class ProfileController < ApplicationController
  def show
      @posts = Post.where(user_id:params[:id]).paginate(:page => params[:page], :per_page => 7).order(created_at: :desc)
      @comment=Comment.new
      @comments = Comment.all
      @user=User.find_by_id(params[:id])
  end
end
