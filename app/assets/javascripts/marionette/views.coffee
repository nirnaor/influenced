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

GraphView = Marionette.View.extend
  template: 'graph'
  ui:
    'canvas' : '.canvas'
  add_influence: (artist, influence)->
    console.log "Will add for #{artist} influence #{influence}"
  onRender: ->
    Backbone.Radio.channel('main').on 'influences_found', (artist) =>
      name = artist.get('name')
      artist.get('influences').forEach (influence) =>
        @add_influence(name, influence)
    g = new Dracula.Graph

    g.addEdge('Banana', 'Tomato')
    g.addEdge('Mushroom', 'Tomato')
    g.addEdge('nir', 'Tomato')
    g.addEdge('nir', 'Mushroom')
    g.addEdge('Banana', 'Mushroom')

    layouter = new Dracula.Layout.Spring(g)
    renderer = new Dracula.Renderer.Raphael('#canvas', g)
    renderer.draw()

@LayoutView =  Marionette.View.extend
  initialize: ->
    @artists = new Backbone.Collection()
  el: '.layout'
  template: 'layout'
  regions:
    search: '.search'
    video: '.video'
    playlist: '.playlist'
    graph: '.graph'
  onRender: ->
    @showChildView('search', new SearchView())
    @showChildView('playlist', new PlaylistView(collection: @artists))
    @showChildView('graph', new GraphView())
    asyncLoadYouTubeAPI()
  showVideo: (artist)->
    @artists.add artist
    @showChildView('video', new VideoView(model: artist))
