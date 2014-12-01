Template.eventPage.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  $.stellar()

Template.registerHelper 'getEventDate', (date)->

  moment(date).lang('ru').format('DD MMM')

Template.registerHelper 'getEventInputDate', (date)->

  moment(date).lang('ru').format('YYYY-MM-DD')


Template.eventPage.events {

  'click .checkin': (e)->

    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click .close-it': (e)->

    $('.custom-modal').removeClass('_visible')
    $('.modal-overlay').removeClass('_visible')


}