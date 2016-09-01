class ReviewsController < ApplicationController
	before_action :require_user
	def new
		@review = Review.new
	end

	def create
		@business = Business.find(params[:business_id])
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

	def review_params
		params.require(:review).permit(:rating, :description)
	end
end