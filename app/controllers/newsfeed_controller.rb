class NewsfeedController < ApplicationController

    before_action :authenticate_user!

    def index
        respond_to do |format|
            format.html{
                @post = Post.new
                @comment = Comment.new
                @comments = Comment.all
                @posts = Post.paginate(:page => params[:page], :per_page => 14).order(created_at: :desc)
                # Post.order(created_at: :desc).page(params[:page])
            }
            format.js {
                @comment = Comment.new
                @comments = Comment.all
                @posts = Post.paginate(:page => params[:page], :per_page => 14).order(created_at: :desc)
                puts "madarchod"
            }
        end
    end

    def users
        respond_to do |format|
            format.html{
                @users = User.search(params[:search],params[:department]).order(name: :desc).paginate(:per_page => 15,:page => params[:page])
            }
            format.js{
                @users = User.search(params[:search]).order(name: :desc).paginate(:per_page => 15,:page => params[:page])
            }
        end
    end

    def profile
        @posts=Post.where(user_id:params[:user_id]).order(created_at: :DESC)
        @comment=Comment.new
        @comments = Comment.all
        user_id=params[:user_id]
        @user=User.find_by_id(user_id)
    end


    def friendrequests
        @friendrequests=Friendrequest.where(receiver_id: current_user.id)

    end





    def ajax
        render :json => {text: "text"}
    end

end
