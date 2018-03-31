class LikesController < ApplicationController

    before_action :authenticate_user!
    def toggle_like
        @post = Post.find(params[:post_id])
        like = Like.where(user: current_user, post: @post).first
        dislike = Dislike.where(user: current_user, post: @post).first

        if like
            like.destroy!
            @is_liked = false
        else
            if current_user.authorized(@post)
                Like.create(user: current_user, post: @post)
                @is_liked = true
                if dislike
                    dislike.destroy!
                    @is_disliked = false
                end
            end

        end

        respond_to do |format|
            format.js { }
        end

    end


end
