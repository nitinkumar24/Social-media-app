class ProfileController < ApplicationController

    def edit_picture
        @user = current_user
    end

    def show
        @user=User.find_by_username(params[:id])
        if @user
            @new_users = User.all

            if @user.id == current_user.id
                @posts = Post.where(user_id:@user.id).paginate(:page => params[:page], :per_page =>7).order(created_at: :desc)
                @comment=Comment.new
                @reply=Reply.new
                @comments = Comment.all
            elsif current_user.is_following @user.id
                @posts = Post.where(user_id:@user.id, anonymous:false).paginate(:page => params[:page], :per_page => 7).order(created_at: :desc)
                @comment=Comment.new
                @reply=Reply.new
                @comments = Comment.all
            end
        else
            render file: "#{Rails.root}/public/404", status: :not_found
        end
    end

end
