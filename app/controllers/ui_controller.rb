class UiController < ApplicationController
  before_action do
    redirect_to :root if Rails.env.production?
  end

  def index
  end
end
