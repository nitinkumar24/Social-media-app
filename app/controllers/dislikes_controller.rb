class DislikesController < ApplicationController

    def toggle_dislike
        @post = Post.find(params[:post_id])
        dislike = Dislike.where(user: current_user, post: @post).first
        like = Like.where(user: current_user, post: @post).first
        if dislike
            dislike.destroy!
            @is_disliked = false
        else
            if current_user.authorized(@post)
                Dislike.create(user: current_user, post: @post)
                @is_disliked = true
                if like
                    like.destroy!
                    @is_liked = false
                end
            end
        end

        respond_to do |format|
            format.js { }
        end
    end
end
