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
  new Calendar('#main-calendar', {month: '11', group: 'children'})

#  $.stellar()


Template.mainLayout.events {

  'click .news .item': ->

    $('#newsModal').modal('show')

}




class @Slider

  autoplay: 8000

  animation: true

  currentSlide: 0

  slidesTotal: null

  _interval: null

  constructor: (options = {})->

    if _.isString options

      @el = $(options)
      @slides = @el.find('.slider-cont>li')

    else

      if !options.el
        console.error 'Should pass jquery selector of target element!'
        return

      @el = $(options.el)
      @interval = options.interval if options.interval?
      @autoplay = options.autoplay if options.autoplay?

    @init()

  init: ->

    console.log 'Aura::slider initialized!'

    @slidesTotal = @el.find('>ul >li').length

    Session.set 'auraSlider.currentSlide', 0

    if @autoplay and @autoplay isnt 0

      @_interval = Meteor.setInterval =>

        @next()

      , @autoplay

    Deps.autorun =>
      console.log 'autorun'
      if Session.get('auraSlider.currentSlide')
        @goTo Session.get('auraSlider.currentSlide')


    $('body').find('.aura-slider-next').on 'click', =>
      @next()
    $('body').find('.aura-slider-prev').on 'click', =>
      @prev()

  _autoplay: ->

    if @_interval
      console.log 'clearing interval'
      Meteor.clearInterval @_interval

    @_interval = Meteor.setInterval =>

      @next()

    , @autoplay


  next: ->

    console.log 'calling next'
    @_autoplay()
    if Session.get('auraSlider.currentSlide') + 2 > @slidesTotal
      Session.set 'auraSlider.currentSlide', 0
    else
      Session.set 'auraSlider.currentSlide', Session.get('auraSlider.currentSlide') + 1


  prev: ->

    @_autoplay()
    if Session.get('auraSlider.currentSlide') is 0
      Session.set 'auraSlider.currentSlide', @slidesTotal - 1
    else
      Session.set 'auraSlider.currentSlide', Session.get('auraSlider.currentSlide') - 1

  goTo: (index)->

    @slides.removeClass '_active'
    @slides.eq(index).addClass '_active'



#Template.mainLayout.events {
#
#  'click .toggle-slide': (e)->
#    $el = $(e.currentTarget)
#    if $el.hasClass 'left'
#      AuraSlider.next()
#    else if $el.hasClass 'left'
#      AuraSlider.prev()

#}
Template.mainLayout.events {

#  'mouseenter [data-tltp]': (e)->
#
#    Tltp.currentElement = $(e.currentTarget)
#    Tltp.show(e)
#
#
#
#  'mouseleave [data-tltp]': (e)->
#
#    Tltp.currentElement = null
#    Tltp.hide(e)

  'click .directions .direction': (e)->
    target = $(e.currentTarget).data('target')
    Router.go '/' + target


}
#
#
#@Tltp = {
#
#  currentElement: null
#  tltpId: null
#
#  show: (e)->
#
#    console.log 'showing tltp'
#
#    shiftTop = -100
#    shiftLeft = 100
#
#    @tltpId = $()
#
#    $el = $(e.currentTarget)
#    content = $el.data('tltp')
#    coordX = $el.offset().left
#    coordY = $el.offset().top
#
#    tltp = $('<p class="tltp"></p>')
#    tltp.text(content)
#    tltp.css('left', coordX + shiftLeft + 'px').css('top', coordY + shiftTop + 'px')
#    $('body').append tltp
#    Meteor.defer ->
#      $('.tltp').addClass '_visible'
#
#  hide: (e)->
#
#    if $(e.currentTarget)
#
#
#
#}



Meteor.Spinner.options = {

  width: 1
  radius: 25

}