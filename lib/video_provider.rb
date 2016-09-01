# Youtube video provider
class VideoProvider
  def search(name)
    url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{name}&order=viewCount&videoCategoryId=10&type=video&key=AIzaSyChE-vTXxk4iqcXjTOtD_JVKawo7Cw3ueU"
    resp = HTTParty.get(url).parsed_response
    resp['items'].map { |v| v['id']['videoId'] }.first
  end
end
