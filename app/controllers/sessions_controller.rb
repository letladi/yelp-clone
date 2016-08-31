class SessionsController < ApplicationController
	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "You logged in successfully. Welcomem back."
			redirect_to root_path
		else
			flash[:error] = "The details you entered were not valid."
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
		flash[:info] = "You have logged out successfully."
	end
end