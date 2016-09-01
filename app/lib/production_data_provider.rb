require 'video_provider'
require 'mtv_influences_provider'

class ProductionDataProvider 
  def video(query)
    VideoProvider.new.search query
  end
  def influences(query)
    MTVInfluencesProvider.new.influences query
  end


end
