    class NewsfeedController < ApplicationController

      before_action :authenticate_user!

      def index
        respond_to do |format|
          format.html{
            @post = Post.new
            @comment=Comment.new
            @comments = Comment.all
            @feed = current_user.feed.limit(50)
          }
          format.js{
            offset = params["offset"]
            if offset
              offset = offset.to_i
            else
              offset = 0
            end

            @new_offset = offset + 10
            @show_load_more = offset < current_user.feed.count
            @feed = current_user.feed.offset(offset).limit(10)
          }
        end

      end

      def users
        @users = User.all
      end

      def ajax
        render :json => {text: "text"}
      end

    end
