# Single point of the API
class HomeController < ApplicationController
  def start
  end

  def video
    render json: ProductionDataProvider.new.video(params[:query])
  end

  def influences
    render json: ProductionDataProvider.new.influences(params[:query])
  end


  def followers
    render json: ProductionDataProvider.new.followers(params[:query])
  end
end
