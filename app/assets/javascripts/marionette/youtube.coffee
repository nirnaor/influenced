@asyncLoadYouTubeAPI = ->
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

@VideoView = Marionette.View.extend
  template: "video"
  render: ->
    id = @model.get('videoid')
    console.log "Will now render video id: #{id}"

    if window.player?
      window.player.loadVideoById(videoId: id)
    else
      window.player = new (YT.Player)('ytplayer',
        height: '390'
        width: '440'
        videoId: id
        events:
          'onReady': @onPlayerReady
          'onStateChange': @onPlayerStateChange)
      return
    console.log 'this is youtube baby'
    # window.playVideo()

  onPlayerStateChange: (event) ->
    console.log 'player state changed'
    window.player.mute()
    if event.data == YT.PlayerState.ENDED
      Backbone.Radio.channel('main').trigger('videoended')

  onPlayerReady: (event) ->
    console.log 'player ready'
    window.player.playVideo()
    return
