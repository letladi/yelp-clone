class BusinessesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :require_categories, only: [:new]
  before_action :get_existing_business, :require_existing_business, only: [:show]

  def index
    @businesses = Business.all
  end

  def show
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

  def get_existing_business
    @business = Business.find_by(id: params[:id])
  end

  def require_categories
    if Category.count.zero?
      flash[:danger] = "Please create a category for your business before adding the business."
      redirect_to new_category_path
    end
  end
end
