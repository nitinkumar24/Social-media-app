class SearchController < ApplicationController

    def mentions
        respond_to do |format|
            format.json { render :json => current_user.mention(params[:q]) }
        end
    end

    def users
        respond_to do |format|
            user_in_same_mode =  UserMode.where(mode: @current_mode)
            uisc_ids = user_in_same_mode.pluck(:user_id)
            puts uisc_ids
            query = params[:query].presence || '*'
            conditions = {}
            conditions[:id] = uisc_ids
            conditions[:sex] = params[:gender] if params[:gender].present?
            conditions[:department] = params[:department] if params[:department].present?
            conditions[:relationstatus] = params[:relationstatus] if params[:relationstatus].present?

            @users = User.search query,fields:[:name], where: conditions, page: params[:page], per_page: 12
            format.html{
            }
            format.js{
            }

        end
    end


    def autocomplete
        data =  User.search(params[:query], {
                fields: ["name",],
                limit: 10,
                load: false,
                misspellings: {below: 5}
        }).map(&:name)
        result = []
        data.each { |x|
            name = {}
            name['name'] = x
            result << name
            puts result
            result = result.uniq
            puts result
        }
        render json: result

    end
end

# format.html{
#     allowed_users_to_show = []
#     if params[:query].present?
#         @find_all_by_params =  User.search params[:query], fields: [:name]
#         @find_all_by_params.each do |user|
#             user_in_same_mode =  UserMode.search "kiet.edu",fields: [:mode], where: { user_id: user.id, }
#             if user_in_same_mode.count>0
#                 allowed_users_to_show << user.id
#             end
#         end
#         @users =  User.where(id: allowed_users_to_show)
#     else
#         @users = UserMode.search "kiet.edu", fields: [:mode]
#     end
#
# }

# puts User.search params[:query], fields: [:name]
# # puts @users.response["hits"]["hits"][0]["_id"]


# @find_all_by_params = if params[:query].present?
#              User.search params[:query], fields: [:name]
#          else
#              User.all
#          end
#
# allowed_users_to_show = [ ]
# @find_all_by_params.each do |user|
#     user_in_same_mode =  UserMode.search cookies[:_mode],fields: [:mode], where: { user_id: user.id, }
#     if user_in_same_mode.count>0
#         allowed_users_to_show << user.id
#     end
# end
#
# @users =  User.where(id: allowed_users_to_show)
# puts @users.length