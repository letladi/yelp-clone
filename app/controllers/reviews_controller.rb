class ReviewsController < ApplicationController
	before_action :require_user, :get_existing_business, :require_existing_business, except: [:index]

	def index
		@reviews = Review.all
	end

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.business = @business
		@review.user = current_user

		if @review.save
			flash[:success] = "Your review was submitted. Thank you."
			redirect_to root_path
		else
			flash[:danger] = "Your review was not submitted."
			render :new
		end
	end

	private

	def get_existing_business
		@business = Business.find_by(id: params[:business_id])
	end

	def review_params
		params.require(:review).permit(:rating, :description)
	end
end