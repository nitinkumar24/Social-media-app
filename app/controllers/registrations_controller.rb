class RegistrationsController < Devise::RegistrationsController

    def create
        super
        open_emails = ["gmail.com","outlook.com","yahoo.com","hotmail.com"]
        user_mail_domain = resource.email.split("@").last
        if open_emails.include? user_mail_domain
            puts "open"
        else
            puts "close"
        end

    end

end