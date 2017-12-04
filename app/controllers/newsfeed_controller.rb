class NewsfeedController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        respond_to do |format|
            format.html{
                @post = Post.new
                @comment=Comment.new
                @comments = Comment.all
                @feed = current_user.feed.limit(10)
                
            }
            format.js{
                offset = params["offset"]
                if offset
                    offset = offset.to_i
                else
                    offset = 0
                end
                
                @new_offset = offset + 10
                @show_load_more = offset < current_user.feed.count
                @feed = current_user.feed.offset(offset).limit(10)
            }
        end
    
    end
    
    
    
    
    def users
        domain=current_user.email.split('@').last
        puts domain
        @users = User.all.order(name: :desc)
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
