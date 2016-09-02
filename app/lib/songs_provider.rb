# Scrapes Google to find songs for an artist
class SongsProvider
  def search(name)
    # Get Id.
    url = "https://api.spotify.com/v1/search?q=#{name}&type=artist"
    res = HTTParty.get(url).parsed_response
    id = res["artists"]["items"].first["id"]

    # Get top tracks of artist Id.
    t_trl = "https://api.spotify.com/v1/artists/#{id}/top-tracks?country=US"
    resp = HTTParty.get(t_trl).parsed_response
    resp['tracks'].map { |s| s["name"] }
  end

end
