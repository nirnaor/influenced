class DevelopmentDataProvider 
  def search(query)
   JSON.parse(File.read(Dir.glob("test/jsons/*").sample))
  end
end
