Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")


SearchView = Marionette.ItemView.extend
  template: "search"
  ui:
    "search": "input[type='text']"
    "start": "input[type='button']"
  events:
    "click @ui.start": "startClick"
  startClick: ->
    search = @ui.search.val()
    console.log search
    $.ajax "/search?search=#{search}",
      success: (data, textStatus, jqXHR )->
        console.log data




$ ->
  console.log 'start'
  view = new SearchView(el: $("body"), model: new Backbone.Model(world: "gil"))
  view.render()
