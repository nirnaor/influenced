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

    channel.on 'videoended', (data)=>
      console.log 'video ended, randomally picking an ifluence...'
      influence = _(@artistData.influences).sample()
      console.log "influence picked: #{influence}"
      @search(influence)

  search: (artist)->
    $.ajax "/search?search=#{artist}",
      success: (data, textStatus, jqXHR)=>
        @artistData = data
        @layout.showVideo(data.video_id)

$ ->
  app = new App()
  app.start()
  asyncLoadYouTubeAPI()
