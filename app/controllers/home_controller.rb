require 'video_provider'
require 'influences_provider'

# Single point of the API
class HomeController < ApplicationController
  def start
  end

  def search
    video_id = VideoProvider.new.search params[:search]
    influences = InfluencesProvider.new.search params[:search]
    render json: influences.merge(video_id: video_id)
  end

  def influences
  end
end
