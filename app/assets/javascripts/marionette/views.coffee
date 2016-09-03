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

  add_node: (n) ->
    return if @nodes._data[n]?
    @nodes.add(id: n, label: n)

  edge_exists: (from, to)->
    for key of @edges._data
      edge = @edges._data[key]
      return true if edge.from == from and edge.to == to
    return false


  add_influence: (artist, influence)->
    console.log "Will not add artist #{artist} with influence #{influence}"
    [artist, influence].forEach (n) => @add_node(n)
    return if @edge_exists(artist, influence)
    @edges.add({from: artist, to: influence})

  onAttach: ->
    @nodes = new vis.DataSet([])
    @edges = new vis.DataSet([])
    container = document.querySelector('.graph_container')
    data = {nodes: @nodes, edges: @edges}
    options = {}
    @network = new vis.Network(container, data, options)

  onRender: ->
    Backbone.Radio.channel('main').on 'influences_found', (artist) =>
      name = artist.get 'name'
      artist.get('influences').forEach (influence) =>
        @add_influence(name, influence)





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
