class LikesController < ApplicationController
    
    before_action :authenticate_user!
    
    def toggle_like
        @post = Post.find(params[:post_id])
        like = Like.where(user: current_user, post: @post).first
        dislike = Dislike.where(user: current_user, post: @post).first
         notification = Notification.where(noti_type_id: @post.id).first
        
        if like
            like.destroy!
            # notification.destroy!
            @is_liked = false
        else
            Like.create(user: current_user, post: @post)
            @is_liked = true
            

            
            if dislike
                dislike.destroy!
                @is_disliked = false
            end
        
        end
        
        respond_to do |format|
            format.js { }
        end
    
    end

end
