module Api
    module V1
        class PasswordsController < Devise::PasswordsController
            # POST /resource/password
            def create
                self.resource = resource_class.send_reset_password_instructions(resource_params)
                yield resource if block_given?

                if successfully_sent?(resource)
                    response_data({}, "Success",200)
                else
                    response_data({}, "Failed",200)
                end
            end

        end
    end
end