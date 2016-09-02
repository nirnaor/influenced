@Artist = Backbone.Model.extend

  fetch: (route, query, callback)->
    $.ajax "/#{route}?query=#{query}",
      success: (data, textStatus, jqXHR)=>
        @set(data)
        callback()

  video: (callback)->
    @fetch('video', @get('query'), =>
      callback())

  influences: (callback)->
    @fetch("influences", @get('name'), callback)
