# Scrapes Google to find songs for an artist
class SongsProvider
  def search(name)
    # Get Id.
    search_url = "https://api.spotify.com/v1/search?q=#{name}&type=artist"
    url = Addressable::URI.parse(search_url).normalize.to_s
    res = HTTParty.get(url).parsed_response

    artist_data = res["artists"]["items"].first
    name = artist_data['name']
    id = artist_data["id"]
    image = artist_data['images'][1]['url']


    # Get top tracks of artist Id.
    t_trl = "https://api.spotify.com/v1/artists/#{id}/top-tracks?country=US"
    resp = HTTParty.get(t_trl).parsed_response
    { name: name, image: image }.merge({ songs: resp['tracks'].map { |s| s["name"] } })
  end

end
