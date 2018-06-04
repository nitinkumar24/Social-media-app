class RegistrationsController < Devise::RegistrationsController

    #check user email and assign mode to use


    def after_update_path_for(resource)
        u =  resource.username
        str = "/"+ u
        str
    end

    def after_sign_up_path_for(resource)
        '/users/sign_up' # Or :prefix_to_your_route
    end

end