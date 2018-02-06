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

end