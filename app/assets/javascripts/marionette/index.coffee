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
    console.log search
    $.ajax "/search?search=#{search}",
      success: (data, textStatus, jqXHR)->
        videoId = data.video_id
        console.log videoId
        Backbone.Radio.channel('main').trigger('videoidrecieved', videoId)

VideoView = Marionette.View.extend
  template: "video"

$ ->
  channel = Backbone.Radio.channel('main')
  channel.on 'videoidrecieved', (id)->
    console.log("i have i video id#{id}")
    video = new VideoView(el: $(".video"), model: new Backbone.Model(videoid: id))
    video.render()

  search = new SearchView(el: $(".start"), model: new Backbone.Model(world: "gil"))
  search.render()
