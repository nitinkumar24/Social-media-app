
class ApiController < ActionController::API

    def authenticate_user_api
        current_user_api
        true
    end

    def current_user_api
        user = User.find_by_email("nitin.1510092@kiet.edu")
        @current_mode = user.current_mode            #for accesing current_mode in controllers
        user.set_mode_for_model @current_mode           #for accesing current_mode in models
        user
    end

    def response_data(data, message, status, error: nil, disabled: false, update: false, params: {})
        result = Hash.new
        result[:data]  = data
        result[:message] = message
        result[:status] = status
        result[:error] = error
        result[:disabled] = disabled
        result[:update] = update
        render json: result, params: params, status: status
    end

end
