class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "new category was created successfully."
      redirect_to root_path
    else
      flash[:danger] = "Category was not created"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
