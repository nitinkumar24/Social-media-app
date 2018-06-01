module Api
    module V1
        class RegistrationsController < Devise::RegistrationsController
            respond_to :json

            def create
                build_resource(sign_up_params)
                resource.accesstoken = "hello"
                print resource.accesstoken
                resource.save
                yield resource if block_given?
                if resource.persisted?
                    if resource.active_for_authentication?
                        sign_up(resource_name, resource)
                        return response_data(params, "Confirmed", 200)
                    else
                        puts "6"
                        expire_data_after_sign_in!
                        return response_data(params, status, 200)
                    end
                else
                    return response_data(resource.errors, "Error", 200)
                end
            end


        end
    end
end
