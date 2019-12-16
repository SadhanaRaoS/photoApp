class UsersController < ApplicationController

	def create
		user = User.find_by(username: user_params[:username])
		unless user
      		user = User.create(user_params)
      		jwt = Auth.issue({user: user.id})
      		redirect_to photos_path, locals: { token: jwt }
      	else 
      		if user && user.authenticate(user_params[:password])
				jwt = Auth.issue({user: user.id})
				session[:user_id] = jwt
				redirect_to photos_path, locals: { token: jwt }

      		else 
      			flash[:message] = "Invalid user name/password"
      			redirect_to login_path
      		end
      	end
	end

	def login
		render 'login.html.erb'
	end



	private 
	def user_params 
		params.require(:user).permit(:username , :password, :password_confirmation)
	end

end
