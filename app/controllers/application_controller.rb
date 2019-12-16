class ApplicationController < ActionController::Base
	 # before_action :authenticate

	def logged_in?
    	!!current_user
  	end

  	def current_user
	    if auth_present?
	      user = User.find(auth["user"])
	      if user
	        @current_user ||= user
	      end
	    end
  	end

  	def authenticate
  		unless logged_in?
    		render json: {error: "unauthorized"}, status: 401 
    	end
      	
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
      		render json: { errors: e.message }, status: :unauthorized
    	end
  	end

  	private 

  	def auth
      Auth.decode(token)
    end

    def token
      request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
    end

  	def auth_present?
      !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first
    end
end
