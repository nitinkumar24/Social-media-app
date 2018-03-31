class RepliesController < ApplicationController
    before_action :set_reply, only: [:show, :edit, :update, :destroy]

    # GET /replies
    # GET /replies.json
    def index
        @replies = Reply.all
    end

    # GET /replies/1
    # GET /replies/1.json
    def show
    end

    # GET /replies/new
    def new
        @reply = Reply.new
    end

    # GET /replies/1/edit
    def edit
        puts 'hellllo'
        puts 'hellllo'
        unless @reply.can_update current_user
            @reply = nil
        end
        respond_to do |format|
            format.js {   }
        end
    end

    # POST /replies
    # POST /replies.json
    def create
        @reply = Reply.new(reply_params)
        @reply.user_id = current_user.id
        @reply.comment_id=params[:comment_id]
        @comment = Comment.find(params[:comment_id])
        @post = @comment.post
        if current_user.authorized(@post)
            respond_to do |format|
                if @reply.save
                    format.html { redirect_to @reply, notice: 'Reply was successfully created.' }
                    format.js {}
                    format.json { render :show, status: :created, location: @reply }
                else
                    format.html { render :new }
                    format.json { render json: @reply.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    # PATCH/PUT /replies/1
    # PATCH/PUT /replies/1.json
    def update
        if @reply.can_update current_user
            respond_to do |format|
                if @reply.update(reply_params)
                    format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
                    format.js {   }
                    format.json { render :show, status: :ok, location: @reply }
                else
                    format.html { render :edit }
                    format.js {   }
                    format.json { render json: @reply.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    # DELETE /replies/1
    # DELETE /replies/1.json
    def destroy
        if @reply.can_update current_user
            @reply.destroy
            respond_to do |format|
                format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
                format.js{}
                format.json { head :no_content }
            end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
        @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
        params.require(:reply).permit(:content, :user_id, :comment_id)
    end
end
