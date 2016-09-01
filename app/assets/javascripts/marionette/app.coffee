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

    channel.on 'artist_picked', (data)=>
      @search(data)

    channel.on 'videoended', => @videoEnded()

  videoEnded: ->
    console.log 'video ended, randomally picking an ifluence...'
    next = _(@artist.get("influenced_by")).sample()
    console.log "influence picked: #{next}"
    @search(next)

  search: (artist)->
    $.ajax "/search?search=#{artist}",
      success: (data, textStatus, jqXHR)=>
        @artist = new Backbone.Model(data)
        @layout.showVideo(@artist)



$ ->
  app = new App()
  app.start()
  asyncLoadYouTubeAPI()
