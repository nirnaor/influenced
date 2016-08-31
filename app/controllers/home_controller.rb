require 'video_provider'

# Single point of the API
class HomeController < ApplicationController
  def start
  end

  def search
    video_id = VideoProvider.new.search params[:search]
    render json: { video_id: video_id }
  end

  def influences
  end
end
