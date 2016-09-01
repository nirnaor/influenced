Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")


SearchView = Marionette.View.extend
  template: "search"
  ui:
    "search": "input[type='text']"
    "start": "input[type='button']"
  events:
    "click @ui.start": "startClick"
  startClick: ->
    search = @ui.search.val()
    Backbone.Radio.channel('main').trigger('artist_picked', search)


App = Marionette.Application.extend
  region: "#application"
  onStart: ->
    channel = Backbone.Radio.channel('main')
    @video = new VideoView(el: $(".video"))
    search = new SearchView(el: $(".start"))
    search.render()

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
        @video.render(data.video_id)

$ ->
  app = new App()
  app.start()
