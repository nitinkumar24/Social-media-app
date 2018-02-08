class SearchController < ApplicationController

    def user
        respond_to do |format|
            format.html{
                @find_all_by_params = if params[:query].present?
                             User.search params[:query], fields: [:name]
                        end

                allowed_users_to_show = []
                @find_all_by_params.each do |user|
                    user_in_same_mode =  UserMode.search "kiet.edu",fields: [:mode], where: { user_id: user.id, }
                    if user_in_same_mode.count>0
                        allowed_users_to_show << user.id
                    end
                end



                @users =  User.where(id: allowed_users_to_show)
                puts @users.length

            }

            format.js{
                @users = if params[:query].present?
                             User.search params[:query], fields: [:name]
                         else
                             User.all
                         end
            }

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


# puts User.search params[:query], fields: [:name]
# # puts @users.response["hits"]["hits"][0]["_id"]