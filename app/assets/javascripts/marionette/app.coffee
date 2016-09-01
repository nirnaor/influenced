Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")

start = ->
  # 2. This code loads the IFrame Player API code asynchronously.
  tag = document.createElement('script')

  window.onYouTubeIframeAPIReady = ->
    console.log 'api is ready'
    $("input[type='button']").click()

  # 4. The API will call this function when the video player is ready.



  tag.src = 'https://www.youtube.com/iframe_api'
  firstScriptTag = document.getElementsByTagName('script')[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag
  # 3. This function creates an <iframe> (and YouTube player)
  #    after the API code downloads.
  player = undefined
  # 5. The API calls this function when the player's state changes.
  #    The function indicates that when playing a video (state=1),
  #    the player should play for six seconds and then stop.
  done = false

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
  start()
