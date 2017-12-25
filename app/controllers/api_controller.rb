class ApiController < ActionController::API

	def response_data data,message,status,disabled: false, update: false

		data = {
			data: data,
			message: message,
			disabled: disabled,
			update: update
		}

		render json: data, status: status
<<<<<<< HEAD
	end
=======
    
>>>>>>> acff4f31dd49ff3429d45e04eefc3cce34c6f9b6
end
