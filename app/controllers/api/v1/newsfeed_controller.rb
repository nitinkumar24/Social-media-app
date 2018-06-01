module Api
    module V1
        class NewsfeedController < ::ApiController
            before_action :authenticate_user_api, except: [:authenticate_user]

            def home
                data = current_user_api.homefeed.as_json(include: :user)
                response_data(data, "Your Feed",200)
            end

            def confessions
                unless current_user_api.current_mode == "open"     #Confessions are not for open mode
                    @posts = Post.includes(:user, :likes, :dislikes, comments: [:replies])
                                     .where(flavour: :confession,mode: @current_mode)
                                     .paginate(:page => params[:page], :per_page => 7)
                                     .order(created_at: :desc)
                end
            end

            def memes
                if @current_mode == 'open'
                    @posts = current_user.memefeed.paginate(:page => params[:page], :per_page => 6)
                else
                    @posts = Post.includes(:user, :likes, :dislikes,comments: [:replies])
                                     .where(flavour: :meme,mode: @current_mode)
                                     .paginate(:page => params[:page], :per_page => 7)
                                     .order(created_at: :desc)
                end
            end


        end
    end
end
