class ProductionDataProvider 
  def video(query)
    VideoProvider.new.search query
  end
  def influences(query)
    MTVInfluencesProvider.new.influences query
  end
end
