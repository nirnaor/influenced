Marionette.Renderer.render = (template_name, data)->
  template = JST["marionette/templates/#{template_name}"]
  if template?
    template(data)
  else
    throw new Error("Can't find template named #{template_name}")


SearchView = Marionette.ItemView.extend
  template: "test"

$ ->
  console.log 'start'
  view = new SearchView(el: $("body"), model: new Backbone.Model(world: "gil"))
  view.render()
