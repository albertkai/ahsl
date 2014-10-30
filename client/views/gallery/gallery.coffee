Template.gallery.rendered = ->
  $.stellar()
  Meteor.defer ->
    $('.wrap').addClass '_animated'