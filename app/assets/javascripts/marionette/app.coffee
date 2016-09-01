Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")

Artist = Backbone.Model.extend
  search: (callback)->
    query = @get('query')
    $.ajax "/search?search=#{query}",
      success: (data, textStatus, jqXHR)=>
        console.log 'search finished'
        @set(data)
        callback(@)

@App = Marionette.Application.extend
  region: "#application"
  onStart: ->
    channel = Backbone.Radio.channel('main')
    @layout = new LayoutView()
    @layout.render()

    channel.on 'artist_searched', (query)=>
      @artist = new Artist(query: query)
      @artist.search => @layout.showVideo(@artist)

    channel.on 'videoended', => @videoEnded()

  videoEnded: ->
    console.log 'video ended, randomally picking an ifluence...'
    next = _(@artist.get("influenced_by")).sample()
    @artist = new Artist(query: next)
    console.log "influence picked: #{next}"
    @artist.search => @layout.showVideo(@artist)




$ ->
  app = new App()
  app.start()
  asyncLoadYouTubeAPI()
