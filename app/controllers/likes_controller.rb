class LikesController < ApplicationController

	before_action :authenticate_user!

	def toggle_like
		if params[:type]=="post"
			@post = Post.find(params[:post_id])
			like = Like.where(user: current_user, post: @post).first
			dislike = Dislike.where(user: current_user, post: @post).first
			if like
				like.destroy!
				@is_liked = false
			else
				Like.create(user: current_user, post: @post)
				if dislike
					dislike.destroy!
					@is_disliked = false
				end
				@is_liked = true
			end

			respond_to do |format|
				format.js { }

			end
		end
	end
end
