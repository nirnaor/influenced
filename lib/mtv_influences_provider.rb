require 'mechanize'

# Scrapes musicbloddline to find influences of an artist.
class MTVInfluencesProvider
  def search(name)

    # Get the JSON search response.
    url = "http://search.mtvnservices.com/typeahead/suggest/?spellcheck.count=5&spellcheck.q=kendr&q=#{name}&siteName=artist_platform&format=json&rows=50"
    resp = HTTParty.get(url).parsed_response
    hash = JSON.parse(resp)

    # Extract the alias name 
    url_name = hash["response"]["docs"].first["platform_artist_alias_s"]

    # Find influences
    url = "http://www.mtv.com/artists/#{url_name}/related-artists/?filter=influencedBy"

    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    agent.get(url)
    { influenced_by: agent.page.search(".title").map {|el| el.inner_html.squish } }
  end
end
