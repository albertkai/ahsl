Template.eventsList.helpers {

  eventsList: ->

#    today = new Date().setHours(0, 0, 0, 0)

#    Events.find({type: 'common', date: {$gte: today}}, {sort: {date: 1}})
    Events.find({type: 'common'}, {sort: {date: 1}})


}

Template.eventsList.rendered = ->

  $('.wrap').addClass '_animated'
  Session.set('eventsRoute', 'event')

Template.masterClassesList.rendered = ->

  $('.wrap').addClass '_animated'
  Session.set('eventsRoute', 'masterclass')

Template.masterClassesListSochi.rendered = ->

  $('.wrap').addClass '_animated'

Template.masterClassesList.helpers {

  masterClassesList: ->

#    today = new Date().setHours(0, 0, 0, 0)

#    Events.find({type: 'masterclass', date: {$gte: today}}, {sort: {date: 1}})

    Events.find({type: 'masterclass'}, {sort: {date: 1}})



}

Template.masterClassesListSochi.helpers {

  masterClassesList: ->

#    today = new Date().setHours(0, 0, 0, 0)

#    Events.find({type: 'masterclass', date: {$gte: today}}, {sort: {date: 1}})

    Events.find({type: 'masterclass_sochi'}, {sort: {date: 1}})



}

['eventsList', 'masterClassesList', 'masterClassesListSochi'].forEach (t)->

  Template[t].events {

    'click [data-alias]': (e)->

      if $(e.target).parent('.remove').length is 0 and !$(e.target).hasClass('remove')

        alias = $(e.currentTarget).data('alias')
        Router.go 'eventPage', {
          alias: alias
        }

      else

        (new PNotify({
          title: 'Удалить событие?',
          text: 'Возможности восстановить его уже не будет',
          hide: false,
          addclass: 'aura-notify',
          confirm: {
            confirm: true
          },
          buttons: {
            closer: false,
            sticker: false
          },
          history: {
            history: false
          }
        })).get().on('pnotify.confirm', ->

          alias = $(e.currentTarget).data('alias')
          Meteor.call 'removeEvent', alias, (err, res)->
            if err
              console.log err
            else
              Aura.notify 'Событие удалено!'

        )


    'click [data-add-event]': (e)->

      if !EventsCtrl.eventCreateModal
        EventsCtrl.eventCreateModal = Blaze.render Template.eventCreateModal, document.body
      else
        $('#event-create-modal').addClass('_opened')

  }




#Template.masterClassesList.events {
#
#  'click [data-alias]': (e)->
#
#    if $(e.target).parent('.remove').length is 0 and !$(e.target).hasClass('remove')
#
#      alias = $(e.currentTarget).data('alias')
#      Router.go 'eventPage', {
#        alias: alias
#      }
#
#    else
#
#      (new PNotify({
#        title: 'Удалить событие?',
#        text: 'Возможности восстановить его уже не будет',
#        hide: false,
#        addclass: 'aura-notify',
#        confirm: {
#          confirm: true
#        },
#        buttons: {
#          closer: false,
#          sticker: false
#        },
#        history: {
#          history: false
#        }
#      })).get().on('pnotify.confirm', ->
#
#        alias = $(e.currentTarget).data('alias')
#        Meteor.call 'removeEvent', alias, (err, res)->
#          if err
#            console.log err
#          else
#            Aura.notify 'Событие удалено!'
#
#      )
#
#
#  'click [data-add-event]': (e)->
#
#    if !EventsCtrl.eventCreateModal
#      EventsCtrl.eventCreateModal = Blaze.render Template.eventCreateModal, document.body
#    else
#      $('#event-create-modal').addClass('_opened')
#
#}
#
#
#Template.eventsList.events {
#
#  'click [data-alias]': (e)->
#
#    if $(e.target).parent('.remove').length is 0 and !$(e.target).hasClass('remove')
#
#      alias = $(e.currentTarget).data('alias')
#      Router.go 'eventPage', {
#        alias: alias
#      }
#
#    else
#
#      (new PNotify({
#        title: 'Удалить событие?',
#        text: 'Возможности восстановить его уже не будет',
#        hide: false,
#        addclass: 'aura-notify',
#        confirm: {
#          confirm: true
#        },
#        buttons: {
#          closer: false,
#          sticker: false
#        },
#        history: {
#          history: false
#        }
#      })).get().on('pnotify.confirm', ->
#
#        alias = $(e.currentTarget).data('alias')
#        Meteor.call 'removeEvent', alias, (err, res)->
#          if err
#            console.log err
#          else
#            Aura.notify 'Событие удалено!'
#
#      )
#
#
#  'click [data-add-event]': (e)->
#
#    if !EventsCtrl.eventCreateModal
#      EventsCtrl.eventCreateModal = Blaze.render Template.eventCreateModal, document.body
#    else
#      $('#event-create-modal').addClass('_opened')
#
#}

Template.registerHelper 'eventGetDay', (date)->

  moment(date).format('DD')

Template.registerHelper 'eventGetMonth', (date)->

  month = moment(date).lang('ru').format('MMMM')
  console.log month
  console.log month.length
  if month is 'август' or month is 'март'
    month + 'a'
  else
    month.substring(0, month.length - 1) + 'я'

Template.registerHelper 'eventGetYear', (date)->

  moment(date).format('YYYY')


@EventsCtrl = {

  eventCreateModal: null

}