class BusinessController < ApplicationController
	before_action :require_user, except: [:index]

	def index
		@businesses = Business.all
	end

	def new
		@business = Business.new
	end

	def create
		@business = Business.new(business_params)
		if @business.save
			flash[:success] = "The business was added successfully."
			redirect_to root_path
		else
			flash[:danger] = "The business was not added successfully."
			render :new
		end
	end

	private

	def business_params
		params.require(:business).permit(:name, :category_id)
	end
end