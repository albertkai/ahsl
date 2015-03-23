Template.successWindow.rendered = ->

  $('.success-window, .success-window-ovrl').addClass('_visible')
  Meteor.setTimeout ->
    $('.success-window, .success-window-ovrl').removeClass('_visible')
  , 4000
  Meteor.setTimeout ->
    $('.success-window, .success-window-ovrl').remove()
  , 5000