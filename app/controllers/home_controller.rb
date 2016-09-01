require 'production_data_provider'
require 'development_data_provider'

# Single point of the API
class HomeController < ApplicationController
  def start
  end

  def video
    render json: ProductionDataProvider.new.search(params[:query])
  end

  def influences
  end
end
