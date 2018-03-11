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
        unless current_user.current_mode == "open"     #Confessions are not for open mode
            @post = Post.new
            @comment = Comment.new
            @reply = Reply.new
            @posts = Post.includes(:user, :likes, :dislikes, :comments)
                             .where(flavour: :confession,mode: @current_mode)
                             .paginate(:page => params[:page], :per_page => 7)
                             .order(created_at: :desc)

            respond_to do |format|
                format.html{
                }
                format.js {
                }
            end
        end
    end

    def memes
        @post = Post.new
        @comment = Comment.new
        @reply = Reply.new
        @posts = Post.includes(:user, :likes, :dislikes, :comments)
                         .where(flavour: :meme,mode: @current_mode)
                         .paginate(:page => params[:page], :per_page => 7)
                         .order(created_at: :desc)

        respond_to do |format|
            format.html{
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
