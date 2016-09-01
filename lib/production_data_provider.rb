require 'video_provider'
require 'influences_provider'

class ProductionDataProvider 
  def search(query)
    video_id = VideoProvider.new.search query
    influences = InfluencesProvider.new.search query
    influences.merge(video_id: video_id)
  end
end
