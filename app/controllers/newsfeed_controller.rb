class NewsfeedController < ApplicationController


    def index
        @post = Post.new
        @comment = Comment.new
        @reply = Reply.new
        @posts = current_user.feed.paginate(:page => params[:page], :per_page => 6)
        @new_users = User.all
        respond_to do |format|
            format.html{
            }
            format.js {
            }
        end
    end

    def confessions
        @post = Post.new
        @comment = Comment.new
        @comments = Comment.all
        @posts = Post.where(flavour: :confession)
                         .paginate(:page => params[:page], :per_page => 7)
                         .order(created_at: :desc)

        respond_to do |format|
            format.html{
                # Post.order(created_at: :desc).page(params[:page])
            }
            format.js {
            }
        end
    end


    def friendrequests
        @friendrequests=Friendrequest.where(receiver_id: current_user.id)
    end



    def ajax
        render :json => {text: "text"}
    end

end
