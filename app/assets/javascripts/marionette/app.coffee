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
      @playArtist(query)

    channel.on 'videoended', => @next()

  onVideoFound: ->
    @layout.showVideo(@artist)
    @artist.influences =>
      related = @artist.get("influences")
      Backbone.Radio.channel('main').trigger('influences_found', @artist)
      if related.length == 0
        related = @artist.get("followers")


  next: ->
    influence = _.sample(@artist.get("influences"))
    @playArtist(influence)

  playArtist: (name)->
    @artist = new Artist(query: name)
    @artist.video => @onVideoFound()




$ ->
  window.app = new App()
  window.app.start()
