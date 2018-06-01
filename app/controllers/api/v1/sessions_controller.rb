module Api
    module V1
        class SessionsController < ApiController

            respond_to :json

            def new
                render json: "Wrong email or password."
            end

            def create
                email = params["user"]["email"]
                password = params["user"]["password"]
                user = User.find_by_email(email)
                if user
                    data = Hash.new
                    unless user.confirmed?
                        return response_data(data, "Confirm your email first", 200)
                    end
                    if user.valid_password? password
                        data["access_token"] = user.accesstoken
                        return response_data(data, "Signed In", 200)
                    else
                        return response_data({}, "Password Invalid", 200)
                    end
                else
                    return response_data({}, "Sign Up first", 200)
                end
            end

        end
    end
end
