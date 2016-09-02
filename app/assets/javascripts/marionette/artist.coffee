@Artist = Backbone.Model.extend
  calculateNames: ->
    splitted = @get('title').split '-'
    return if splitted.length < 2
    @set('name', splitted[0])
    @set('song', splitted[1])

  fetch: (route, query, callback)->
    $.ajax "/#{route}?query=#{query}",
      success: (data, textStatus, jqXHR)=>
        @set(data)
        callback()

  video: (callback)->
    @fetch('video', @get('query'), =>
      @calculateNames()
      callback())

  influences: (callback)->
    @fetch("influences", @get('name'), callback)
