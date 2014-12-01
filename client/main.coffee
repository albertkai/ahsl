#Subscriptions

Meteor.subscribe 'events'


Template.mainLayout.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'
  Meteor.setTimeout ->
    $('#events-carousel').carousel({
      interval: 4000
    })

    $('#partners-carousel').carousel({
      interval: 4000
    })

    $('#top-slider').carousel({
      interval: 6000
    })
  , 200

  $('#top-slider').find('ul li').first().addClass 'active'

  $('body').find('header nav a.disabled').on 'click', (e)->
    e.preventDefault()
    Aura.notify 'Извините, раздел в разработке', 'Приносим изменения за временные неудобства'


#  @mainSlider = new Slider('.aura-slider')
  new Calendar('#main-calendar', {group: 'children'})

#  $.stellar()


Template.mainLayout.events {

  'click .news .item': ->

    $('#newsModal').modal('show')

  'click .directions .direction': (e)->
    console.log 'clicked dir'
    if !$(e.target).data('aura-html') and !$(e.target).data('aura-with-html') and !$(e.target).data('aura-list-html')
      if !Session.get('admin.editMode')
        target = $(e.currentTarget).data('target')
        Router.go '/' + target


}


Meteor.Spinner.options = {

  width: 1
  radius: 25

}