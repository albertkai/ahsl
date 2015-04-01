#Subscriptions

Meteor.subscribe 'events'
Meteor.subscribe 'news'
#Meteor.subscribe 'requests'
Meteor.subscribe 'slider'
Meteor.subscribe 'summerSlider'
Meteor.subscribe 'schedules', ->
  Session.set 'schedule', 'loaded'


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

  , 200

  $('#top-slider').find('ul li').first().addClass 'active'

  $('body').find('header nav a.disabled').on 'click', (e)->
    e.preventDefault()
    Aura.notify 'Извините, раздел в разработке', 'Приносим изменения за временные неудобства'

  Deps.autorun ->
    if Session.get('schedule') is 'loaded'
      console.log 'deps wrked'
      console.log 'schedule loaded'
      if $('#main-calendar').length > 0
        new Calendar('#main-calendar', {group: 'children'})


#  @mainSlider = new Slider('.aura-slider')

#  $.stellar()

Template.slider.rendered = ->

  @.$('#top-slider').find('ul li').first().addClass 'active'

  @.$('#top-slider').carousel({
    interval: 6000
  })

  @.$('.slider-edit').find('ul').sortable({
    items: 'li:not(.add-slide)'
    stop: (e, ui)->
      IndexCtrl.reorderSlides()
  })

Template.slider.helpers {

  'slider': ->

    Slider.find({}, {sort: {order: 1}})

}

Template.slider.events {

  'click .add-slide': ->

    IndexCtrl.addSlide()

  'click .remove': (e)->

    IndexCtrl.removeSlide(e)

  'click .slider-cont > li': (e)->
    console.log 'clicked'
    if $(e.currentTarget).data('link') isnt '' and !$(e.target).is('input')
      Router.go('/' + $(e.currentTarget).data('link'))

  'click .slider-edit .slide-item': (e)->

    $('#top-slider').carousel($(e.currentTarget).index())

  'click #slider-edit-button': ->

    $('.slider-edit').addClass('_opened')

  'click .close-slider-edit': ->

    $('.slider-edit').removeClass('_opened')


}

Template.mainLayout.helpers {

  'mainEvents': ->

    Events.find({'mainPage': true}, {sort: {date: 1}})

  'mainNews': ->

    News.find({'mainPage': true}, {sort: {date: 1}})

  'getEventsCarousel': (mainEvents)->

    markup = '<div class="item active"><div class="row">'
    events = mainEvents.fetch()
    for i in [0...events.length]
      if i % 4 is 0 and i isnt 0
        markup += '</div></div><div class="item"><div class="row">'
      markup += Blaze.toHTMLWithData(Template.eventItem, events[i])
    markup += '</div></div>'
    markup



}


Template.mainLayout.events {

  'click .news .item': (e)->

    console.log 'clicked'

    id = $(e.currentTarget).data('id')

    if $(e.target).parent('.remove').length is 0 and !$(e.target).hasClass('remove')

      console.log  News.findOne({_id: id})

      if NewsCtrl.openedModal
        Blaze.remove NewsCtrl.openedModal

      NewsCtrl.openedModal = Blaze.renderWithData Template.newsItemOpened, News.findOne({_id: id}), document.body

  'click .directions .direction': (e)->
    console.log 'clicked dir'
    if !$(e.target).data('aura-html') and !$(e.target).data('aura-with-html') and !$(e.target).data('aura-list-html')
      if !Session.get('admin.editMode')
        target = $(e.currentTarget).data('target')
        Router.go '/' + target

  'click .events .event': (e)->
    alias = $(e.currentTarget).data('alias')
    Router.go 'eventPage', {alias: alias}


}



Meteor.startup ->

  $('body').on 'click', '.custom-modal .close-it', (e)->

    $('.custom-modal').removeClass('_visible')
    $('.modal-overlay').removeClass('_visible')

  $('body').on 'click', '.modal-overlay', (e)->

    $('.custom-modal').removeClass('_visible')
    $('.modal-overlay').removeClass('_visible')

  $('body').on 'click', '.rdo >div', (e)->
    $(e.currentTarget).closest('.rdo').addClass('_active').siblings().removeClass('_active')




Meteor.Spinner.options = {

  width: 1
  radius: 75
  lines: 24

}


@IndexCtrl = {

  reorderSlides: ->

    $('.slider-edit').find('ul .slide-item').each ->
      Slider.update {_id: $(this).data('id')}, {$set: {order: $(this).index()}}

  addSlide: ->

    index = Slider.find().count()

    Slider.insert {

      pic: ''
      desc: 'Описание слайда'
      order: index
      link: ''

    }

    $('#top-slider').carousel(index)



  removeSlide: (e)->

    $target = $(e.currentTarget).closest('li')
    order = $target.data('order')
    Slider.find().fetch().forEach (s)->
      if s.order > order
        Slider.update {_id: s._id}, {$inc: {order: -1}}
    Slider.remove {_id: $target.data('id')}
    $('#top-slider').find('ul li').removeClass('active').first().addClass 'active'
    $('#top-slider').carousel({
      interval: 6000
    })


}