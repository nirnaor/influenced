require 'mechanize'

# Scrapes musicbloddline to find influences of an artist.
class InfluencesProvider
  def search(name)
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    agent.get('http://musicbloodline.info')

    # Click for 'search link'
    agent.click agent.page.search("a[href='#search']").first

    # Enter name in the search form
    form = agent.page.forms.first
    form.query = name
    form.submit

    # Click on first result
    first_result = agent.page.links.second
    agent.click first_result

    # Return array of influences
    lists = agent.page.search('ul')
    { influences: get_names(lists[2]), influenced_by: get_names(lists[3]) }
  end

  def get_names(list)
    return [] if list.nil?
    list.search('a').map(&:text)
  end
end
