class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    before_action :set_raven_context
    before_action :check_mode

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
            user_params.permit(:email, :password, :password_confirmation,:name)
        end

        devise_parameter_sanitizer.permit(:account_update) do |user_params|
            user_params.permit(:email, :password, :password_confirmation,:name,:avatar,:current_password, :relationstatus, :sex, :about, :avatar_original_w, :avatar_original_h, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,:avatar_box_w, :avatar_aspect)
        end
    end

    private

    # sentry
    def set_raven_context
        Raven.user_context(id: session[:current_user_id]) # or anything else in session
        Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def check_mode
        cookies[:_mode] = rand(10...42)
        if controller_name != 'sessions'
            if not cookies[:_mode].nil?
                puts "hello"
            else
                render 'newsfeed/mode'
            end
        end

    end

end
