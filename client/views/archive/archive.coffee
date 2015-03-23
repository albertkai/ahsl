Template.archive.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

Template.archive.helpers {

  'events': ->

    today = new Date().setHours(0, 0, 0, 0)

    Events.find({date: {$lte: today}}, {sort: {date: 1}})


}

Template.archive.events {

  'click .item': (e)->
    if $(e.target).parent('.remove').length is 0 and !$(e.target).hasClass('remove')

      alias = $(e.currentTarget).data('alias')
      Router.go 'eventPage', {
        alias: alias
      }

}