onPlayerReady = (event) ->
  console.log 'player ready'
  window.player.playVideo()
  return

stopVideo = ->
  window.player.stopVideo()
  return


onPlayerStateChange = (event) ->
  console.log 'player state changed'
  if event.data == YT.PlayerState.ENDED
    Backbone.Radio.channel('main').trigger('videoended')

@VideoView = Marionette.View.extend
  initialize: (options) ->
    console.log options
    @start()
  template: "video"
  render: (id)->
    if window.player?
      window.player.loadVideoById(videoId: id)
    else
      window.player = new (YT.Player)('ytplayer',
        height: '390'
        width: '640'
        videoId: id
        events:
          'onReady': onPlayerReady
          'onStateChange': onPlayerStateChange)
      return
    console.log 'this is youtube baby'
    # window.playVideo()
  start: ->
    # 2. This code loads the IFrame Player API code asynchronously.
    tag = document.createElement('script')

    window.onYouTubeIframeAPIReady = ->
      console.log 'api is ready'

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
