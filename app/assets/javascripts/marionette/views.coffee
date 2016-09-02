SearchView = Marionette.View.extend
  template: "search"
  ui:
    "search": "textarea"
    "start": "button"
  events:
    "click @ui.start": "startClick"
  startClick: ->
    search = @ui.search.val()
    Backbone.Radio.channel('main').trigger('artist_searched', search)


PlaylistItemView = Marionette.View.extend
  template: 'playlistitem'
  className: 'playlistitem'

PlaylistView = Marionette.CollectionView.extend
  childView: PlaylistItemView

@LayoutView =  Marionette.View.extend
  initialize: ->
    @artists = new Backbone.Collection()
  el: '.layout'
  template: 'layout'
  regions:
    search: '.search'
    video: '.video'
    playlist: '.playlist'
  onRender: ->
    @showChildView('search', new SearchView())
    @showChildView('playlist', new PlaylistView(collection: @artists))
  showVideo: (artist)->
    @artists.add artist
    @showChildView('video', new VideoView(model: artist))
