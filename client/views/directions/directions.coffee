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

Template.onlineSchool.rendered = ->

  console.log 'summer rendered'

  Session.set('onlinePayType', 'full')
  Session.set('onlinePayPrice', 18000)
  Session.set('payLater', false);

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Deps.autorun ->

    if Session.get('schedule') is 'loaded'
      console.log 'schedule loaded'
      if $('.direction-onlineSchool').length > 0
        Meteor.setTimeout ->
          new Calendar('#group-schedule', {
            group: 'onlineSchool_morning'
            drawGroups: false
          })
        , 1500
        DirCtrl.scheduleLoaded = true

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.onlineSchool.helpers {

  isPayType: (type)->
    Session.equals('onlinePayType', type)

  currentPrice: ->
    Session.get('onlinePayPrice')

}

Template.onlineSchool.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

  'click .pay-later input': (e)->
    Session.set('payLater', $(e.currentTarget).is(':checked'))


  'click .choose-special-price .chckbx > div': (e)->

    Session.set('onlinePayType', $(e.currentTarget).closest('.chckbx').data('type'))
    Session.set('onlinePayPrice', $(e.currentTarget).closest('.chckbx').data('price'))


  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
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

      title = 'Покупка онлайн обучения: ' + Session.get('onlinePayType')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()
      requestId = Random.id()
      eventDate = Date.now()
      type = 'card'
      eventType = 'onlineCourses'
      amount = Session.get('onlinePayPrice') + '.00'
      place = 'No place'
      eventTime = 'No time'
      additional = {}
      Meteor.call 'addRequest', title, name, phone, email, type, eventType, eventDate, eventTime, place, requestId, additional, amount, (err, resp)->

        if err
          console.log err
        else
          console.log 'Request email sent!'

          console.log 'Starting transactional machinery'

          console.log(requestId)
          console.log(amount)

          if Session.get('payLater')

            title = 'Запись на онлайн-обучение'
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

            Meteor.call 'sendOnlineTransactionalEmail', options, (err, res)->

              console.log 'sending transactional email'

              if err
                console.log err
#              else
#                NProgress.done()
#                $('.custom-modal').addClass('_shifted')
#                $('.sccss').addClass('_shifted')
#                Meteor.setTimeout ->
#                  $('.custom-modal').removeClass('_shifted').removeClass('_visible')
#                  $('.sccss').removeClass('_shifted')
#                  $('.modal-overlay').removeClass '_visible'
#                , 4000

          else

            Meteor.call 'payment', 'card', requestId, amount, (err, res)->

              window.location.href = res

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

Template.facebookShare.onRendered ->

  console.log('loading srcipt')
  d = document
  s = 'script'
  id = 'facebook-jssdk'
  fjs = d.getElementsByTagName(s)[0]
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.6&appId=287085884968214";
  fjs.parentNode.insertBefore(js, fjs);

Template.facebookShare.onDestroyed ->
  $('#facebook-jssdk').remove()
  $('#fb-root').removeClass('fb_reset')
  $('#fb-root').html('')

Template.facebookShare.helpers({
  lind: ->
    window.location.href
})
