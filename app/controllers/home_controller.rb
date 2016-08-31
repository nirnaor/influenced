class HomeController < ApplicationController
  def start
  end

  def search
    render json: {message: params[:search]}
  end

  def influences
  end
end
