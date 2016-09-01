require 'video_provider'
require 'mtv_influences_provider'

class ProductionDataProvider 
  def search(query)
    VideoProvider.new.search query
  end
  def influences(query)
    MTVInfluencesProvider.new.search query
  end


end