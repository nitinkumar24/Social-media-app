class ProfileController < ApplicationController

    def edit_picture
        @user = current_user
    end

    def followers
            @followers = current_user.followers(current_user.id, current_user.current_mode).paginate(:page => params[:page], :per_page =>7)
    end

    def following
        @followee = current_user.followee(current_user.id, current_user.current_mode).paginate(:page => params[:page], :per_page =>7)
    end

    def show
        @user=User.find_by_username(params[:id])
        if @user
            if @user.id == current_user.id
                @posts = Post.includes(:user, :likes, :dislikes, :comments).where(user_id:@user.id).paginate(:page => params[:page], :per_page =>7).order(created_at: :desc)
                @comment=Comment.new
                @reply=Reply.new
                @comments = Comment.all

            elsif current_user.can_un_follow @user.id        #means following
                @posts = Post.includes(:user, :likes, :dislikes, :comments).where(user_id:@user.id, anonymous:false).paginate(:page => params[:page], :per_page => 7).order(created_at: :desc)
                @comment=Comment.new
                @reply=Reply.new
                @comments = Comment.all
            else
                @posts = nil

            end
        else
            render file: "#{Rails.root}/public/404", status: :not_found
        end
    end

end
