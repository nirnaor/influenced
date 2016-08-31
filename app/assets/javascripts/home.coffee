$ ->
  console.log "Testing"
  console.log _
  console.log Backbone
  console.log Backbone.Marionette
  console.log "window loaded"
  html = JST["test"]({world: "nir"})
  $("body").html html
