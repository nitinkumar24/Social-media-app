

class UsersApiController <  ActionController::API

	def response_data data,message,status,disabled: false, update: false
		data = {
			data: data,
			message: message,
			disabled: disabled,
			update: update
		}
		render json: data, status: status
	end


	def sign_up
		email=params["email"]
		password=params["password"]
		user=User.find_by_email(email)
		data={}
		if user
			return response_data(data, "User already exists",200)
		end
		user=User.new
		user.email=email
		user.password=password
		data["email"]=email
		return response_data(data, "User created",200)
	end


	def sign_in 
		email=params["email"]
		password=params["password"]
		user=User.find_by_email(email)
		if user

			if user.valid_password? password
				data =Hash.new
				data["access_token"]=user.access_token
				return response_data(data ,"Signed In" ,200)
			else
				return response_data({},"Password Invalid", 200)				
			end				

		else
			return response_data({},"User doesn't exist", 200)
		end

		return response_data({}, "Signed In",200)
	end


end