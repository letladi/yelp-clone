class UsersController < ApplicationController
	before_action :get_existing_user, :require_existing_user, only: [:show]
	
	def new
		@user = User.new
	end

	def show
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
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

	def get_existing_user
		@user = User.find_by(id: params[:id])
	end

	def require_existing_user
    unless @user
      flash[:danger] = "The specified user does not exist."
      redirect_back(fallback_location: root_path) 
    end
  end
end