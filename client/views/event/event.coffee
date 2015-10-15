Template.eventPage.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  Tracker.autorun ->

    chosenType = Session.get('chosenType')
    $('.types').find('button').removeClass('_active')
    $('[data-type="' + chosenType + '"]').addClass('_active')

#  $('[data-toggle="popover"]').popover({
#    html: true
#    trigger: 'hover'
#  })

#  if $('#isSpecial').val() is 'true'
#    specialPrice1 = $('.choose-special-price > .chckbx:nth-child(1)').val()
#    specialPrice2 = $('.choose-special-price > .chckbx:nth-child(2)').val()
#    Session.set('specialPrice', specialPrice1 + specialPrice2)
#    Tracker.autorun ->
#      $('.special-price').find('span:nth-child(2)').html(Session.get('specialPrice') + 'р')

  $('#event-user-phone').inputmask("+7(999)999-99-99")

  Session.set('chosenType', 'live')

  if Router.current().location.get().path.split('?')[1] is 'payment=true'

    $.scrollTo('.variants', {offset: -100})


  $('#type-select').val(@data.type)

  $('select').select2({
    minimumResultsForSearch: -1
  })

  $.stellar()

Template.registerHelper 'getEventDate', (date)->

  moment(date).lang('ru').format('DD MMMM')

Template.registerHelper 'getEventInputDate', (date)->

  moment(date).lang('ru').format('YYYY-MM-DD')


Template.eventPage.helpers {

  currentPrice: ->

    if Session.get('chosenType') is 'live'
      @price
    else if Session.get('chosenType') is 'webinar'
      @webinarPrice
    else if Session.get('chosenType') is 'video'
      @videoPrice

  isInvisible: ->

    if @type is 'masterclass_sochi'

      '_invisible'

  special: ->

    if Router.current().location.get().path is '/event/detilly' or Router.current().location.get().path is '/event/detilly?payment=true'
      if Session.get('eventType') is 'masterclass'

        true



}

Template.eventPage.events {

  'click .checkin, click #toggle-special': (e)->

    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

    if @isSpecial

      Session.set('chosenPrice', 5900)

    else

      Session.set('chosenPrice', parseInt $(e.currentTarget).siblings('.price').html().replace(/\D+/, ''))
      Session.set('eventType', $(e.currentTarget).data('type'))

  'click .types button': (e)->

    type = $(e.currentTarget).data('type')
    Session.set('chosenType', type)

  'click .add-previous': (e)->

    collection = $(e.target).closest('[data-aura-collection]').data('aura-collection')
    index = $(e.target).closest('[data-aura-index]').data('aura-index')
    document = $(e.target).closest('[data-aura-with]').data('aura-with')
    price = $('[data-aura-with-html="price"]').html()

    updateQuery = {}
    updateQuery[index] = document

    AuraColl[collection].update updateQuery, {$set: {pricePrev: price}}

  'click .chckbx > div': (e)->

    $(e.currentTarget).closest('.chckbx').toggleClass('_active')

    if $(e.currentTarget).closest('.chckbx').hasClass('_active') and $(e.currentTarget).closest('.chckbx').hasClass('dinner')
      $(e.currentTarget).closest('.chckbx').siblings('.dinner').removeClass('_active')

    specialPrice1 = do ->
      if $('.choose-special-price > .chckbx:nth-child(1)').hasClass('_active')
        parseInt $('.choose-special-price > .chckbx:nth-child(1)').data('value')
      else
        0
    specialPrice2 = do ->
      if $('.choose-special-price > .chckbx:nth-child(2)').hasClass('_active')
        parseInt $('.choose-special-price > .chckbx:nth-child(2)').data('value')
      else
        0

    specialPrice3 = do ->
      if $('.choose-special-price > .chckbx:nth-child(4)').hasClass('_active')
        parseInt $('.choose-special-price > .chckbx:nth-child(4)').data('value')
      else
        0

    $('.special-price').find('span:nth-child(2)').html(specialPrice1 + specialPrice2 + specialPrice3 + 'р')

    Session.set('chosenPrice', specialPrice1 + specialPrice2 + specialPrice3)

  'click .del-previous': (e)->

    collection = $(e.target).closest('[data-aura-collection]').data('aura-collection')
    index = $(e.target).closest('[data-aura-index]').data('aura-index')
    document = $(e.target).closest('[data-aura-with]').data('aura-with')

    updateQuery = {}
    updateQuery[index] = document

    AuraColl[collection].update updateQuery, {$set: {pricePrev: null}}

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    console.log 'checking form'
    if $('#event-user-name').val() isnt '' and $('#event-user-phone').val() isnt '' and re.test($('#event-user-email').val())

      if $('#event-user-name').val() is ''
        $('#event-user-name').addClass '_invalid'
      else
        $('#event-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#event-user-email').val())
        $('#event-user-email').addClass '_invalid'
      else
        $('#event-user-email').removeClass('_invalid').addClass '_valid'
      if $('#event-user-phone').val() is ''
        $('#event-user-phone').addClass '_invalid'
      else
        $('#event-user-phone').removeClass('_invalid').addClass '_valid'

      title = $('[data-aura-with-html="title"]').html()
      name = $('#event-user-name').val()
      phone = $('#event-user-phone').val()
      email = $('#event-user-email').val()
      requestId = Random.id()
      eventDate = $('#event-date').html()
      type = $('.payment-method').find('.rdo._active').data('value')
      eventType = Session.get('eventType')
      amount = Session.get('chosenPrice') + '.00'
      place = $('[data-aura-with-html="place"]').html()
      eventTime = $('[data-aura-with-html="time"]').html()
      additional = {}
      if Session.get('eventType') is 'webinar'
          additional['link'] = $('#webinar-link').val()
          additional['pass'] = $('#webinar-pass').val()

      sendText = 'Имя: ' + name + '\n Телефон: ' + phone + '\n Email: ' + email + '\n Оплата: ' + type

      Meteor.call 'sendRequestEmail', title, sendText, (err, res)->

        if err
          console.log err
        else
          console.log 'Request email sent!'

      Meteor.call 'addRequest', title, name, phone, email, type, eventType, eventDate, eventTime, place, requestId, additional, amount, (err, res)->

        if err
          console.log err
        else
          console.log 'request added'

          console.log 'Starting transactional machinery'

          if type is 'card' or type is 'webmoney'

            Meteor.call 'payment', type, requestId, amount, (err, res)->

              window.location.href = res

          else

            console.log 'Starting simple sending process'

            NProgress.start()

            options = {
              title: title
              name: name
              phone: phone
              email: email
              type: type
              date: eventDate
              place: place
              time: eventTime
            }

            console.log 'yoo'

            Meteor.call 'sendTransactionalEmail', options, (err, res)->

              console.log 'sending transactional email'

              if err
                console.log err
              else
                NProgress.done()
                $('.custom-modal').addClass('_shifted')
                $('.sccss').addClass('_shifted')
                Meteor.setTimeout ->
                  $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                  $('.sccss').removeClass('_shifted')
                  $('.modal-overlay').removeClass '_visible'
                , 4000


    else

      if $('#event-user-name').val() is ''
        $('#event-user-name').addClass '_invalid'
      else
        $('#event-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#event-user-email').val())
        $('#event-user-email').addClass '_invalid'
      else
        $('#event-user-email').removeClass('_invalid').addClass '_valid'
      if $('#event-user-phone').val() is ''
        $('#event-user-phone').addClass '_invalid'
      else
        $('#event-user-phone').removeClass('_invalid').addClass '_valid'

}

