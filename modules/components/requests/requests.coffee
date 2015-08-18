if Meteor.isClient

  Meteor.call 'getRequestsCount', (err, res)->

    Session.set('allRequests', res[0])
    Session.set('newRequests', res[1])
    Session.set('errorRequests', res[2])
    Session.set('recallRequests', res[3])
    Session.set('successRequests', res[4])

  requestsHandle = Meteor.subscribeWithPagination('requestsPaginated', 10)


  Template.auraRequestsModal.rendered = ->



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

    'click .status button': (e)->

      $target = $(e.target).closest('li')
      id = $target.data('id')
      status = $(e.currentTarget).data('status')
      Requests.update {_id: id}, {$set: {status: status}}

    'click aside .rdo > div': (e)->

      Session.set 'requestsSort', $(e.currentTarget).closest('.rdo').data('value')

  }


  Template.auraRequestsModal.helpers {

    requests: ->

      query = {
        date: {$exists: true}
      }
      if Session.get('requestsSort') and Session.get('requestsSort') isnt 'all'
        query['status'] = Session.get('requestsSort')
      Requests.find(query, {sort: {date: -1}})

    showEmail: (email)->

      console.log email
      email

    allRequests: ->

      Session.get 'allRequests'

    newRequests: ->

      Session.get 'newRequests'

    errorRequests: ->

      Session.get 'errorRequests'

    recallRequests: ->

      Session.get 'recallRequests'

    successRequests: ->

      Session.get 'successRequests'

    unwatched: ->

      Requests.find().count()

    isActive: (status, current)->

      if status is current
        '_active'

    isPayed: (status)->

      if status
        'да'
      else
        'нет'

    isWatched: (status)->

      if status is 'unwatched'

        false

      else

        true

  }


if Meteor.isServer

  Meteor.publish 'requestsPaginated', (limit)->

    Requests.find({}, {limit: limit, sort: {$natural:-1}})


  Meteor.methods {

    'getRequestsCount': ->

      all = Requests.find().count()
      newReq = Requests.find({status: 'unwatched'}).count()
      errorReq = Requests.find({status: 'error'}).count()
      recallReq = Requests.find({status: 'recall'}).count()
      successReq = Requests.find({status: 'success'}).count()

      [all, newReq, errorReq, recallReq, successReq]
  }