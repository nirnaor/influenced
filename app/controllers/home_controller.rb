require 'video_provider'
require 'influences_provider'

# Single point of the API
class HomeController < ApplicationController
  def start
  end

  def search
    video_id = VideoProvider.new.search params[:search]
    influences = InfluencesProvider.new.search params[:search]
    render json: { video_id: video_id, influences: influences}
  end

  def influences
  end
end
