Session.setDefault('mapLoaded', false)

Template.children.rendered = ->

  console.log 'children rendered'

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  Deps.autorun ->
    if Session.get('schedule') is 'loaded'
      console.log 'schedule loaded'
      if $('.direction-children').length > 0
        new Calendar('#group-schedule', {
          group: 'children'
          drawGroups: false
        })

  Meteor.setTimeout ->
    $('.classes-header').find('.lead').first().trigger('click')
  , 1000

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'



Template.children.events {

  'click .classes-header .row > div button': (e)->


    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      console.log 'sending request'

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Запись в группу: ' + $(e.currentTarget).data('group')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

}

Template.teens.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Meteor.setTimeout ->
    $('.classes-header').find('.lead').first().trigger('click')
  , 1000

  Deps.autorun ->
    if Session.get('schedule') is 'loaded'
      console.log 'schedule loaded'
      if $('.direction-teens').length > 0
        new Calendar('#group-schedule', {
          group: 'teens_day'
          drawGroups: false
        })

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.teens.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Запись в группу: ' + $(e.currentTarget).data('group')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

}

Template.lateteens.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Meteor.setTimeout ->
    $('.classes-header').find('.lead').first().trigger('click')
  , 1000

  Deps.autorun ->
    if Session.get('schedule') is 'loaded'
      console.log 'schedule loaded'
      if $('.direction-lateteens').length > 0
        new Calendar('#group-schedule', {
          group: 'lateTeens'
          drawGroups: false
        })

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.lateteens.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Запись в группу: ' + $(e.currentTarget).data('group')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

}


Template.grownups.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  Meteor.setTimeout ->
    $('.classes-header').find('.lead').first().trigger('click')
  , 1000

  Deps.autorun ->
    if Session.get('schedule') is 'loaded'
      console.log 'schedule loaded'
      if $('.direction-grownups').length > 0
        new Calendar('#group-schedule', {
          group: 'grownUps'
          drawGroups: false
          chooseTime: true
        })


  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.international.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Meteor.setTimeout ->
    $('.custom-tab').first().addClass '_active'
    $('.classes-header .row > div').first().addClass '_active'
  , 800

Template.international.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

}

Template.grownups.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Запись в группу: ' + $(e.currentTarget).data('group')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()
      NProgress.start()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

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
              , 2000

    else

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

}


Template.summerSchool.rendered = ->

  console.log 'summer rendered'

  Meteor.setTimeout ->
    $('.classes-header').find('.lead').first().trigger('click')
  , 1000

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Deps.autorun ->

    if Session.get('schedule') is 'loaded'
      console.log 'schedule loaded'
      if $('.direction-summerSchool').length > 0
        new Calendar('#group-schedule', {
          group: 'summerSchool'
          chooseTime: true
          drawGroups: false
          month: 5
          limit: [5, 7]
        })

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'



Template.summerSchool.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Запись в группу: ' + $(e.currentTarget).data('group')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

}

Template.onlineSchool.onDestroyed ->

  Session.set('mapLoaded', false)

Template.onlineSchool.rendered = ->

  fbq('track', "PageView")

  unless Session.get('mapLoaded')
    script = document.createElement("script")
    script.type = "text/javascript"
    script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyD2g8-K77DKK9yBkZNmdC_Jhdp299S5oR8&libraries=places&callback=initializeAutocomplete"
    document.body.appendChild(script)
    Session.set('mapLoaded', true)

  console.log 'summer rendered'

  Session.set('onlinePayType', 'full')
  Session.set('onlinePayPrice', 5900)
  Session.set('payLater', false);

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

#  Deps.autorun ->
#
#    if Session.get('schedule') is 'loaded'
#      console.log 'schedule loaded'
#      if $('.direction-onlineSchool').length > 0
#        Meteor.setTimeout ->
#          new Calendar('#group-schedule', {
#            group: 'onlineSchool_morning'
#            drawGroups: false
#          })
#        , 1500
#        DirCtrl.scheduleLoaded = true

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'
  Meteor.setTimeout ->
    $('.classes-header').find('.lead').first().trigger('click')
  , 1000

Template.onlineSchool.helpers {

  isPayType: (type)->
    Session.equals('onlinePayType', type)

  currentPrice: ->
    Session.get('onlinePayPrice')

  getDiscountedPrice: (price, discount)->
    console.log price
    console.log discount
    discount = (100 - Math.abs(parseInt(discount, 10))) / 100
    Math.round(parseInt(price, 10) * discount)

  onlinePackName: ->
    Session.get('onlinePackName')

  onlinePackType: ->
    Session.get('onlinePackType')

  gotChoice: ->
    Session.get('onlinePackType') isnt 'ввв'

  onlinePackFullPrice: ->
    Session.get('onlinePackFullPrice')

  onlinePackVideoPrice: ->
    Session.get('onlinePackVideoPrice')

  classOverlayHeader: -> Session.get('classOverlayHeader')
  classOverlaySrc: -> Session.get('classOverlaySrc')
  classOverlayDesc: -> Session.get('classOverlayDesc')


}

Template.onlineSchool.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click #online-nav a': (e)->
    e.preventDefault()
    $el = $(e.currentTarget).attr('href')
    $('body').scrollTo $el, 800

  'click .pay-later input': (e)->
    Session.set('payLater', $(e.currentTarget).is(':checked'))

  'click .reviews-link': (e)->
    unless $(e.target).closest('button').hasClass('close-it')
      Router.go('/reviews')


  'click .choose-special-price .chckbx > div': (e)->

    Session.set('onlinePayType', $(e.currentTarget).closest('.chckbx').data('type'))
    Session.set('onlinePayPrice', $(e.currentTarget).closest('.chckbx').data('price'))


  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('#direction-lead').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click .pack ul li': (e)->
    unless Session.get('admin.editMode')
      headerName = $(e.currentTarget).html().trim()
      console.log(headerName)
      $classTab = $("[data-class-header='" + headerName + "']")
      console.log($classTab)
      imgSrc = $classTab.find('img').attr('src')
      desc = $classTab.find('.class-desc').html()
      Session.set({
        classOverlayHeader: headerName
        classOverlaySrc: imgSrc
        classOverlayDesc: desc
      })
      $('.class-overlay').addClass('_opened')

  'click .class-overlay .close': ->

    $('.class-overlay').removeClass('_opened')

  'click .reviews-link .close-it': ->
    $('.reviews-link').remove()

  'click .pack .lead': (e)->
    name = $(e.currentTarget).closest('.pack').find('h2').text()
    fullPrice = $(e.currentTarget).closest('.pack').find('.full').find('.actual').text()
    videoPrice = $(e.currentTarget).closest('.pack').find('.video').find('.actual').text()
    Session.set('onlinePackName', name)
    Session.set('onlinePackType', $(e.currentTarget).data('type'))
    Session.set('onlinePayPrice', parseInt(fullPrice, 10))
    Session.set('onlinePackFullPrice', parseInt(fullPrice, 10))
    Session.set('onlinePackVideoPrice', parseInt(videoPrice, 10))
    $('#direction-lead').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    console.log('Sending payment request')

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      fbq('track', 'Lead')
      yaCounter27185078.reachGoal('Lead')

      title = 'Покупка онлайн обучения: ' + Session.get('onlinePackName') + 'Тип: ' + Session.get('onlinePayType')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()
      city = $('#direction-user-city').val()
      requestId = Random.id()
      eventDate = Date.now()
      type = 'card'
      eventType = 'onlineCourses'
      amount = Session.get('onlinePayPrice') + '.00'
      place = 'No place'
      eventTime = 'No time'
      additional = {}

      text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email + '\n Город: ' + city

      NProgress.start()
      Meteor.call 'addRequest', title, name, phone, email, type, eventType, eventDate, eventTime, place, requestId, additional, amount, (err, resp)->

        if err
          console.log err
        else
          console.log 'Request email sent!'

          console.log 'Starting transactional machinery'

          console.log(requestId)
          console.log(amount)

#          if Session.get('payLater')
#
#            title = 'Запись на онлайн-обучение'
#
#            options = {
#              title: title
#              name: name
#              phone: phone
#              email: email
#              type: type
#              date: eventDate
#              place: place
#              time: eventTime
#              pack: Session.get('onlinePackType')
#            }
#
#            console.log 'yoo'
#
#            Meteor.call 'sendOnlineTransactionalEmail', options, (err, res)->
#
#              console.log 'sending transactional email'
#
#              if err
#                console.log err
#              else
#                NProgress.done()
#                $('.custom-modal').addClass('_shifted')
#                $('.sccss').addClass('_shifted')
#                Meteor.setTimeout ->
#                  $('.custom-modal').removeClass('_shifted').removeClass('_visible')
#                  $('.sccss').removeClass('_shifted')
#                  $('.modal-overlay').removeClass '_visible'
#                , 4000
#
#          else
#
#            $('.wait-for-pay').addClass('_visible')
#
#            Meteor.call 'payment', 'card', requestId, amount, (err, res)->
#
#              window.location.href = res


          title = 'Запись на онлайн-обучение'

          options = {
            title: title
            name: name
            phone: phone
            email: email
            type: type
            date: eventDate
            place: place
            time: eventTime
            pack: Session.get('onlinePackType')
          }

          console.log 'yoo'

          $('.wait-for-pay').addClass('_visible')

          Meteor.call 'sendOnlineTransactionalEmail', options, (err, res)->

            console.log 'sending transactional email'

            if err
              console.log err
            else
#              NProgress.done()
#              $('.custom-modal').addClass('_shifted')
#              $('.sccss').addClass('_shifted')
#              Meteor.setTimeout ->
#                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
#                $('.sccss').removeClass('_shifted')
#                $('.modal-overlay').removeClass '_visible'
#              , 4000
              console.log('success')

            Meteor.call 'payment', 'card', requestId, amount, (err, res)->

              window.location.href = res

      Meteor.call 'sendRequestEmail', title, text, (err, response)->

        if err
          console.log err
        else
          console.log('request received')

    else

      console.log('Validation not passed')

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

}

@DirCtrl = {

  scheduleLoaded: false

}

#Template.facebookShare.onRendered ->
#
#  console.log('loading srcipt')
#  d = document
#  s = 'script'
#  id = 'facebook-jssdk'
#  fjs = d.getElementsByTagName(s)[0]
#  js = d.createElement(s); js.id = id;
#  js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.6&appId=287085884968214";
#  fjs.parentNode.insertBefore(js, fjs);
#
#Template.facebookShare.onDestroyed ->
#  $('#facebook-jssdk').remove()
#  $('#fb-root').removeClass('fb_reset')
#  $('#fb-root').html('')


Template.facebookShare.events {
  'click button': (e, template)->
    console.log(template)
    container = document.createElement('div');
    text = document.createTextNode(template.data.desc)
    container.appendChild(text)
    desc = container.innerHTML
    FB.ui({
      method: 'share',
      app_id: 287085884968214,
      picture: 'http://d1tvqt3gjtui5j.cloudfront.net/images/' + template.data.img,
      href: window.location.href,
      link: window.location.href,
      description: desc,
      title: 'Austrian Higher School of Etiquette'
      name: 'AHSE'
    }, (err, res)=>
      console.log(err)
      console.log(res)
      console.log(window.location.href);
    );
}

Template.facebookShare.helpers({
  lind: ->
    window.location.href
})

getName = (type, count)=>
  if  9 < count < 21
    if type is 'days'
      'дней'
    else if type is 'hours'
      'часов'
    else if type is 'minutes'
      'минут'
  else
    lastNum = parseInt((count + '').slice(-1))
    if lastNum is 1
      if type is 'days'
        'день'
      else if type is 'hours'
        'час'
      else if type is 'minutes'
        'минута'
    else if 1 < lastNum < 5
      if type is 'days'
        'дня'
      else if type is 'hours'
        'часа'
      else if type is 'minutes'
        'минуты'
    else
      if type is 'days'
        'дней'
      else if type is 'hours'
        'часов'
      else if type is 'minutes'
        'минут'


Template.counter.onCreated ->

  @days = new ReactiveVar(0)
  @hours = new ReactiveVar(0)
  @minutes = new ReactiveVar(0)
  @daysH = new ReactiveVar('дней')
  @hoursH = new ReactiveVar('часов')
  @minutesH = new ReactiveVar('минут')

Template.counter.onRendered ->

  console.log('Shit rendered')
  diff = moment(@data.date).diff(moment(Date.now() + 10800000))
  console.log(diff)
  if (diff > 0)
    dur = moment.duration(diff)
    console.log(dur)
    @days.set(dur._data.days)
    @hours.set(dur._data.hours)
    @minutes.set(dur._data.minutes)
    @daysH.set(getName('days', dur._data.days))
    @hoursH.set(getName('hours', dur._data.hours))
    @minutesH.set(getName('minutes', dur._data.minutes))
  else
    @days.set(0)
    @hours.set(0)
    @minutes.set(0)
    Meteor.call('extendDiscount', @data.field)
  @interval = Meteor.setInterval =>
    console.log('Shit rendered')
    diff = moment(@data.date).diff(moment(Date.now() + 10800000))
    console.log(diff)
    if (diff > 0)
      dur = moment.duration(diff)
      console.log(dur)
      @days.set(dur._data.days)
      @hours.set(dur._data.hours)
      @minutes.set(dur._data.minutes)
    else
      @days.set(0)
      @hours.set(0)
      @minutes.set(0)
  , 60000

Template.counter.helpers {
  dateVerb: ->
    moment(Template.instance().data.date).format('DD.MM.YYYY')
  days: ->
    if Template.instance().days
      Template.instance().days.get()
  hours: ->
    if Template.instance().hours
      Template.instance().hours.get()
  minutes: ->
    if Template.instance().minutes
      Template.instance().minutes.get()
  daysHeader: ->
    Template.instance().daysH.get()
  hoursHeader: ->
    Template.instance().hoursH.get()
  minutesHeader: ->
    Template.instance().minutesH.get()
}

Template.counter.onDestroyed ->
  Meteor.clearInterval(@interval)


@initializeAutocomplete = ->

  @autocompleteCity = new google.maps.places.Autocomplete document.getElementById('direction-user-city'), {types: ['(cities)']}
  google.maps.event.addListener autocompleteCity, 'place_changed', ->
    console.log('place changed')



