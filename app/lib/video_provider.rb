# Youtube video provider
class VideoProvider
  def search(name)
    data = SongsProvider.new.search(name)
    song = data[:songs].sample
    query = "#{name} #{song}"
    youtube_url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{query}&order=viewCount&videoCategoryId=10&type=video&key=AIzaSyChE-vTXxk4iqcXjTOtD_JVKawo7Cw3ueU"
    url = Addressable::URI.parse(youtube_url).normalize.to_s
    resp = HTTParty.get(url).parsed_response
    video = resp['items'].first 
    data.merge({ videoid: video['id']['videoId'], title: video["snippet"]["title"]})
  end
end
