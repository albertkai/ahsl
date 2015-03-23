Template.gallery.rendered = ->
  $.stellar()
  Meteor.defer ->
    $('.wrap').addClass '_animated'
  $('.main-pic').find('.spinner-container').addClass '_visible'
  Meteor.setTimeout ->
    Gallery.countPreviewTape()
  , 200

