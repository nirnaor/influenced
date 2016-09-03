Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")


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
      related = @artist.get("influences")
      Backbone.Radio.channel('main').trigger('influences_found', @artist)
      if related.length == 0
        related = @artist.get("followers")
      @next(related)

  next: (related)->
    next = _(related).sample()
    @artist = new Artist(query: next)
    console.log "influence picked: #{next}"
    @artist.video => @layout.showVideo(@artist)




$ ->
  app = new App()
  app.start()
