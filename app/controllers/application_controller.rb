class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    before_action :set_raven_context
    before_action :check_user_blocked
    before_action :check_user_mode
    before_action :set_paper_trail_whodunnit

    private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
            user_params.permit(:email, :password, :password_confirmation,:name, :username)
        end
        devise_parameter_sanitizer.permit(:account_update) do |user_params|
            user_params.permit(:username, :email, :password, :password_confirmation,:name,:avatar,:current_password,
                               :relationstatus, :sex, :about, :department, :avatar_original_w, :avatar_original_h,
                               :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,:avatar_box_w,
                               :avatar_aspect)
        end
    end


    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end

    # sentry
    def set_raven_context
        Raven.user_context(id: session[:current_user_id]) # or anything else in session
        Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def check_user_blocked
            puts "in check"
            allowed_controllers = ["sessions","registrations","confirmations","passwords","omniauth_callbacks"]
            puts controller_name
            unless allowed_controllers.include? controller_name
               if UserBlock.where(email: current_user.email).length > 0
                   render 'newsfeed/blocked_user_message'
               end
            end
    end

    def check_user_mode
        puts "in check"
        allowed_controllers = ["mode","sessions","registrations","confirmations","passwords","omniauth_callbacks"]
        puts controller_name
        unless allowed_controllers.include? controller_name
            puts "beta"
            if  current_user.current_mode.nil?
                puts "in if"
                redirect_to '/mode/select'
            else
                puts "in else"
                @current_mode = current_user.current_mode            #for accesing current_mode in controllers
                puts @current_mode
                current_user.set_mode_for_model @current_mode           #for accesing current_mode in models

            end

        end
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
