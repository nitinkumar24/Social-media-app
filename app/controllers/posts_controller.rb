class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts
    # GET /posts.json


    # GET /posts/1
    # GET /posts/1.json


    # GET /posts/new


    # GET /posts/1/edit


    # POST /posts
    # POST /posts.json
    def create
        @post = Post.new(post_params)

        @post.user_id = current_user.id
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

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json


    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        if kabil
            @post.destroy!
            respond_to do |format|
                format.html { redirect_to '/', notice: 'Post was successfully destroyed.' }
                format.json { head :no_content }
                format.js{
                }
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
        if kabil
            respond_to do |format|
                if @post.update(post_params)
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

    def kabil
        @post.user.id == current_user.id
    end

end
