module Api
    module V1
        class ConfirmationsController < Devise::ConfirmationsController
            def create
                self.resource = resource_class.send_confirmation_instructions(resource_params)
                yield resource if block_given?
                if successfully_sent?(resource)
                    response_data({}, "Success",200)
                else
                    if resource.confirmed?
                        response_data({}, "Already confirmed",200)
                    else
                        response_data({}, "Please sign up",200)

                    end
                end
            end
        end
    end
end
