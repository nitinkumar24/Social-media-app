class NotificationsController < ApplicationController

    def show
        current_user.new_notifications = 0
        current_user.save
        @notifications=Notification.includes(:user).where(:recipient_id => current_user.id,mode: @current_mode)
                               .paginate(:page => params[:page], :per_page => 15)
                               .order(created_at: :desc)
        respond_to do |format|
            format.html{
            }
            format.js {
            }
        end
    end

    def view
        noti_type = params[:noti_type]
        noti_type_id = params[:noti_type_id]

        if noti_type == "post-comment" or noti_type == "comment-mention"
            @comment_to_show = []
            @comment_to_show << Comment.where(id: noti_type_id).first       #because @comment k lie edit wala form aa ja rha h, islie @comments
            @post_to_show = @comment_to_show[0].post if @comment_to_show[0]
            unless current_user.authorized(@post_to_show)
                @post_to_show = nil
            end

        elsif noti_type == "comment-reply" or noti_type == "reply-mention"
            @comment_to_show = []
            @reply = Reply.where(id: noti_type_id).first
            @comment_to_show << @reply.comment if @reply
            @post_to_show = @comment_to_show[0].post if  @comment_to_show[0]
            unless current_user.authorized(@post_to_show)
                @post_to_show = nil
            end

        elsif noti_type == "post-like"
            @comment_to_show = []
            @like = Like.where(id: noti_type_id).first
            @post_to_show = @like.post if @like
            unless current_user.authorized(@post_to_show)
                @post_to_show = nil
            end
            @comment_to_show << @post_to_show.comments  if @post_to_show

        elsif noti_type ==  "post-mention"
            @comment_to_show = []
            @post_to_show = Post.where(id: noti_type_id).first
            unless current_user.authorized(@post_to_show)
                @post_to_show = nil
            end
            @comment_to_show << @post_to_show.comments if @post_to_show

        else
            redirect_to '/' , notice: 'something went wrong'
        end

        @comment = Comment.new
        @reply = Reply.new
        puts noti_type

    end

end
