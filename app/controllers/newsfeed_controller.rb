class NewsfeedController < ApplicationController


    def index
        @post = Post.new
        @comment = Comment.new
        @reply = Reply.new
        @posts = current_user.homefeed.paginate(:page => params[:page], :per_page => 6)
        @new_users = User.where(current_mode: @current_mode).order(created_at: :desc).limit(6)
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
        @new_users = User.where(current_mode: @current_mode).order(created_at: :desc).limit(6)
    end

    def memes
        @post = Post.new
        @comment = Comment.new
        @reply = Reply.new
        if @current_mode == 'open'
            @posts = current_user.memefeed.paginate(:page => params[:page], :per_page => 6)
        else
            @posts = Post.includes(:user, :likes, :dislikes, :comments)
                             .where(flavour: :meme,mode: @current_mode)
                             .paginate(:page => params[:page], :per_page => 7)
                             .order(created_at: :desc)
        end
        respond_to do |format|
            format.html{
            }
            format.js {
            }
        end
        @new_users = User.where(current_mode: @current_mode).order(created_at: :desc).limit(6)

    end



    def ajax
        render :json => {text: "text"}
    end

end
