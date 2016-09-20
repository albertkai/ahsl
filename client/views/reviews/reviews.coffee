Template.reviews.onRendered ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
    $(".reviews").sortable({
      items: '.item:not(.add)'
      scroll: true
      stop: (e, ui)->
        newReviews = []
        $('.reviews').find('.item:not(.add)').each (i)->
          r = Blaze.getData($(this).get(0))
          r.order = i + 1
          newReviews.push r
        Meteor.call 'updateReviews', newReviews
    })


Template.reviews.helpers

  reviews: ->
    rev = _.sortBy AuraPages.findOne({name: 'reviews'})?.reviews, (r)-> r.order
    console.log rev
    rev



Template.reviews.events

  'click .remove': (e)->
    picToDelete = Blaze.getData(e.target).pic
    $(e.currentTarget).closest('.item').remove()
    newReviews = []
    $('.reviews').find('.item:not(.add)').each (i)->
      pic = Blaze.getData($(this).get(0)).pic
      order = i + 1
      newReviews.push {pic: pic, order: order, _id: Random.id()}
    Meteor.call 'deletePic', picToDelete, 'ahsl2/images', (err, res)->
      if err
        console.log err
      else
        Meteor.call 'updateReviews', newReviews

  'click .toggle-small': ->
    $('#reviews').toggleClass('_small')

  'change #add-review': (e)->
    file = e.target.files[0]
    fr = new FileReader()
    fr.onload = ->
      pic = {}
      pic['data'] = fr.result
      pic['name'] = file.name
      pic['size'] = file.size
      pic['type'] = file.type
      Meteor.call 'uploadPic', pic, 'ahsl2/images', (err, newName)->
        if err then console.log err
        Meteor.call 'addReview', newName

    fr.readAsBinaryString(file)