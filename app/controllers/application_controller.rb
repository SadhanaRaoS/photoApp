class ApplicationController < ActionController::Base
	 # before_action :authenticate

	def logged_in?
    	!!@current_user
  	end

  	def authorize_request
    	header = session[:user_id]
    	begin
      		@decoded = Auth.decode(header)
      		@current_user = User.find(@decoded["user"])
      		params[:current_user] = @current_user.id
    	rescue ActiveRecord::RecordNotFound => e
      		render json: { errors: e.message }, status: :unauthorized
    	rescue JWT::DecodeError => e
      		redirect_to login_path
    	end
  	end

end
