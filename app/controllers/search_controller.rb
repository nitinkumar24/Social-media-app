class SearchController < ApplicationController

    def user
        respond_to do |format|
            format.html{
                @users = if params[:query].present?
                             User.search params[:query], fields: [:name]
                         else
                             User.all
                         end
            }
            format.js{
                @users = if params[:query].present?
                             User.search params[:query], fields: [:name]
                         else
                             User.all
                         end            }
        end
    end


    def autocomplete
         render json: User.search(params[:query], {
                fields: ["name",],
                limit: 10,
                load: false,
                misspellings: {below: 5}
        })
    end

end
