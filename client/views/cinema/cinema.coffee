Template.cinema.rendered = ->

  console.log 'cinema rendered'

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()


Template.cinema.helpers {

  girls: ->
    cursor = Girls.find({}, {sort: {votes: -1}}).map (m, i)->
      item = _.extend m, {iter: i + 1}
      item
    cursor

  gotText: (text)->
    text isnt ''

  getIndex: (i)->
    console.log i

}

Template.cinema.events {

  'click .video': (e)->

    link = Blaze.getData(e.target).link
    window.location.href = link

  'click .lead': (e)->
    id = Blaze.getData(e.target)._id
    console.log id
    unless localStorage['ahslVoted']?
      fingerprint = navigator.appVersion + '//' + navigator.productSub + '//' + navigator.userAgent
      Meteor.call 'vote', id, fingerprint, (err, voted)->
        if err?
          console.log err
        else
          if voted
            console.log 'Voted'
            $('#voted').addClass '_shifted'
            $('.modal-overlay').addClass('_visible')
            Meteor.setTimeout ->
              $('#voted').removeClass '_shifted'
              $('.modal-overlay').removeClass('_visible')
            , 2800
            localStorage.setItem('ahslVoted', id)
          else
            $('#cant-vote').addClass '_shifted'
            $('.modal-overlay').addClass('_visible')
            Meteor.setTimeout ->
              $('#cant-vote').removeClass '_shifted'
              $('.modal-overlay').removeClass('_visible')
            , 2800
            console.log 'Cant vote'

}