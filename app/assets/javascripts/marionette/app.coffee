Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")

Artist = Backbone.Model.extend
  calculateNames: ->
    splitted = @get('title').split '-'
    return if splitted.length < 2
    @set('name', splitted[0])
    @set('song', splitted[1])

  fetch: (route, query, callback)->
    $.ajax "/#{route}?query=#{query}",
      success: (data, textStatus, jqXHR)=>
        @set(data)
        callback()

  video: (callback)->
    @fetch('video', @get('query'), =>
      @calculateNames()
      callback())

  influences: (callback)->
    @fetch("influences", @get('name'), callback)

@App = Marionette.Application.extend
  region: "#application"
  onStart: ->
    channel = Backbone.Radio.channel('main')
    @layout = new LayoutView()
    @layout.render()

    channel.on 'artist_searched', (query)=>
      @artist = new Artist(query: query)
      @artist.video => @layout.showVideo(@artist)

    channel.on 'videoended', => @videoEnded()

  videoEnded: ->
    console.log 'video ended, fetching influences...'
    @artist.influences =>
      next = _(@artist.get("influences")).sample()
      @artist = new Artist(query: next)
      console.log "influence picked: #{next}"
      @artist.video => @layout.showVideo(@artist)




$ ->
  app = new App()
  app.start()
  asyncLoadYouTubeAPI()
