require 'production_data_provider'

# Single point of the API
class HomeController < ApplicationController
  def start
  end

  def search
    render json: ProductionDataProvider.new.search(params[:search])
  end

  def influences
  end
end
