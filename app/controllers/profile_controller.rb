class ProfileController < ApplicationController
    def show
        @user=User.find_by_id(params[:id])
        if @user.id == current_user.id  or current_user.is_following @user.id
            @posts = Post.where(user_id:params[:id]).paginate(:page => params[:page], :per_page => 7).order(created_at: :desc)
            @comment=Comment.new
            @comments = Comment.all
        end

    end

end
