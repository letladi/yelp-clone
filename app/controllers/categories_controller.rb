class CategoriesController < ApplicationController 
	before_action :require_user
	def new
		@category = Category.new
	end
end