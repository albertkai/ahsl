if Meteor.isClient

  requestsHandle = Meteor.subscribeWithPagination('requestsPaginated', 10)


  Template.auraRequestsModal.rendered = ->

    #

  Template.auraRequestsModal.events {

    'click .load-more': ->

      console.log 'Loading next requests'

      requestsHandle.loadNextPage()

    'click .list-wrap .title': (e)->

      $target = $(e.target).closest('li')
      $target.toggleClass('_expanded')
      if $target.hasClass('_unwatched')
        id = $target.data('id')
        Requests.update {_id: id}, {$set: {isWatched: true}}
        $target.removeClass('_unwatched')

  }


  Template.auraRequestsModal.helpers {

    requests: ->

      Requests.find({date: {$exists: true}}, {sort: {date: -1}})

    unwatched: ->

      Requests.find().count()

    isPayed: (status)->

      if status
        'да'
      else
        'нет'

  }


if Meteor.isServer

  Meteor.publish 'requestsPaginated', (limit)->

    Requests.find({}, {limit: limit, sort: {$natural:-1}})

  Requests.find({}).fetch().forEach (r)->

    Requests.update r._id, {$set: {isWatched: false}}