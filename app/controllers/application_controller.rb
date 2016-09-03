class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :require_existing_business

  def require_user
  	unless current_user
  		flash[:danger] = "You must be logged in to do that."
  		redirect_to login_path
  	end
  end

  def current_user
  	User.find(session[:user_id]) if session[:user_id]
  end

  def require_existing_business
    unless @business
      flash[:danger] = "The specified business does not exist."
      redirect_back(fallback_location: root_path) 
    end
  end
end
