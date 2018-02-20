class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def create

        puts "hi"
        puts post_params
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        check_anonymous_avatar_create
        @comment=Comment.new
        respond_to do |format|

            if @post.save
                format.html { redirect_to '/', notice: 'Post was successfully created.' }
                format.js {   }
                format.json { render :show, status: :created, location: @post }
            else
                format.html { render 'newsfeed/index' }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end


    def destroy
        if @post.can_edit_or_delete current_user
            @post.destroy!
            respond_to do |format|
                format.html { redirect_to '/', notice: 'Post was successfully destroyed.' }
                format.json { head :no_content }
                format.js{ }
            end
        else
            redirect_to '/', notice: 'that was not cool'
        end
    end


    def show
        @comment=Comment.new
        @comments = Comment.all
    end

    def update
        if @post.can_edit_or_delete current_user
            respond_to do |format|
                if @post.update(post_params)
                    check_anonymous_avatar_update
                    format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                    format.json { render :show, status: :ok, location: @post }
                else
                    format.html { render :edit }
                    format.json { render json: @post.errors, status: :unprocessable_entity }
                end
            end
        else
            redirect_to '/', notice: 'that was not cool'
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
        @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:post).permit(:content, :user_id,:anonymous,:avatar, :flavour)
    end

   
    def check_anonymous_avatar_create
        if @post.anonymous and @post.avatar?
            puts @post.avatar.destroy
            puts @post.avatar
        end
    end

    def check_anonymous_avatar_update
        if @post.anonymous and @post.avatar?
            @post.anonymous = false
            @post.save
            puts @post.anonymous
        end
    end

end


# GET /posts
# GET /posts.json


# GET /posts/1
# GET /posts/1.json


# GET /posts/new


# GET /posts/1/edit


# POST /posts
# POST /posts.json

# PATCH/PUT /posts/1
# PATCH/PUT /posts/1.json


# DELETE /posts/1
# DELETE /posts/1.json