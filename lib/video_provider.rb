# Youtube video provider
class VideoProvider
  def search(name)
    url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{name}&key=AIzaSyChE-vTXxk4iqcXjTOtD_JVKawo7Cw3ueU"
    res = HTTParty.get(url).parsed_response
    videos = res['items'].select { |i| i['id']['kind'] == 'youtube#video' }
    videos.map { |v| v['id']['videoId'] }.first
  end
end
