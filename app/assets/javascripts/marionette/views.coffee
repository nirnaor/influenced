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

@LayoutView =  Marionette.View.extend
  el: '.layout'
  template: 'layout'
  regions:
    search: '.search'
    video: '.video'
  onRender: ->
    @showChildView('search', new SearchView())
  showVideo: (artist)->
    @showChildView('video', new VideoView(model: artist))
