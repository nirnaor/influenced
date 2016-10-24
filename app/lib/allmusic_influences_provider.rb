require 'mechanize'

# Scrapes musicbloddline to find influences of an artist.
class AllmusicInfluencesProvider
  def influences(name)
    {influences: related(name, "influencers") }.merge({followers: related(name, "followers")})
  end

  def related(name, filter)
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    agent.get("http://www.allmusic.com/search/typeahead/all/#{name}")
    artists = agent.page.search('.artist-results ul li.result')

    if artists.size == 0
      return []
    end

    artist_url = artists.first.attribute('data-url').value
    agent.get("#{artist_url}/related")
    agent.page.search("section.related.#{filter} ul li a").map {|el| el.inner_html }
  end
end
