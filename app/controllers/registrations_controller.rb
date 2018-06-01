class RegistrationsController < Devise::RegistrationsController

    #check user email and assign mode to user
    def create
        super
        open_emails = ["gmail.com","outlook.com","yahoo.com","hotmail.com"]
        user_mail_domain = resource.email.split("@").last
        if open_emails.include? user_mail_domain
            UserMode.create(user_id: resource.id, mode: "open")
        else
            UserMode.create(user_id: resource.id, mode: user_mail_domain)
        end
    end


    def after_update_path_for(resource)
        u =  resource.username
        str = "/"+ u
        str
    end

    def after_sign_up_path_for(resource)
        '/users/sign_up' # Or :prefix_to_your_route
    end

end