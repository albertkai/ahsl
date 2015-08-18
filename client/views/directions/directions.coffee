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

    if Session.get('schedule') is 'loaded' and !DirCtrl.scheduleLoaded
      console.log 'schedule loaded'
      if $('.direction-summerSchool').length > 0
        new Calendar('#group-schedule', {
          group: 'summerSchool'
          chooseTime: true
          drawGroups: false
          month: 5
          limit: [5, 7]
        })
        DirCtrl.scheduleLoaded = true

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

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

#  Deps.autorun ->
#
#    if Session.get('schedule') is 'loaded' and !DirCtrl.scheduleLoaded
#      console.log 'schedule loaded'
#      if $('.direction-onlineSchool').length > 0
#        new Calendar('#group-schedule', {
#          group: 'onlineSchool'
#          drawGroups: false
#        })
#        DirCtrl.scheduleLoaded = true

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.onlineSchool.events {

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

@DirCtrl = {

  scheduleLoaded: false

}