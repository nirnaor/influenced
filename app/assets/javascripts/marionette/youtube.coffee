onPlayerReady = (event) ->
  console.log 'player ready'
  window.player.playVideo()
  return

stopVideo = ->
  window.player.stopVideo()
  return


onPlayerStateChange = (event) ->
  console.log 'player state changed'
  window.player.pauseVideo()
  if event.data == YT.PlayerState.ENDED
    Backbone.Radio.channel('main').trigger('videoended')

@VideoView = Marionette.View.extend
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
