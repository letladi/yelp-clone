class BusinessController < ApplicationController
	before_action :require_user, except: [:index]

	def index
		@businesses = Business.all
	end

	def new
		@business = Business.new
	end

	def create
		flash[:success] = "The business was added successfully."
		redirect_to root_path
	end
end