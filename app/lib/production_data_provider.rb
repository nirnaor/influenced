class ProductionDataProvider 
  def video(query)
    VideoProvider.new.search query
  end
  def influences(query)
    AllmusicInfluencesProvider.new.influences query
  end
end
