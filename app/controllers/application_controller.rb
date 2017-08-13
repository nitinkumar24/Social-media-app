class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:account_update) do |u|
          	u.permit(:name, :email, :password, :current_password, :avatar)
          	end
    end

end
