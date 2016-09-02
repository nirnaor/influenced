class DevelopmentDataProvider 
  def video(query)
   JSON.parse(File.read(Dir.glob("test/jsons/*").sample))
  end
end
