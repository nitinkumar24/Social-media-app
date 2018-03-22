class NotificationsController < ApplicationController

    def show
        current_user.new_notifications = 0
        current_user.save
        @notifications=Notification.where(:recipient_id => current_user.id,mode: @current_mode).reverse
    end

    def view
        noti_type = params[:noti_type]
        noti_type_id = params[:noti_type_id]

        if noti_type == "post-comment" or noti_type == "comment-mention"
            @comment_to_show = []
            @comment_to_show << Comment.where(id: noti_type_id).first       #because @comment k lie edit wala form aa ja rha h, islie @comments
            @post_to_show = @comment_to_show[0].post
        end
        if noti_type == "comment-reply" or noti_type == "reply-mention"
            @comment_to_show = []
            @reply = Reply.where(id: noti_type_id).first
            @comment_to_show << @reply.comment
            @post_to_show = @comment_to_show[0].post
        end

        if noti_type == "post-like"
            @comment_to_show = []
            @like = Like.where(id: noti_type_id).first
            @post_to_show = @like.post
            @comment_to_show << @post_to_show.comments

        end

        if noti_type ==  "post-mention"
            @comment_to_show = []
            @post_to_show = Post.where(id: noti_type_id).first
            @comment_to_show << @post_to_show.comments
        end

        @comment = Comment.new
        @reply = Reply.new
        puts noti_type

    end

end
