Template.direction.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  new Calendar('#group-schedule', {
    group: 'children'
    month: '10'
    drawGroups: false
  })

  Meteor.defer ->
    $('body').stellar()