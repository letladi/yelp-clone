class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "You registered successfully. Welcome."
			redirect_to root_path
		else
			flash[:danger] = "Your form submission was invalid."
			render :new
		end
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end
end