if Meteor.isClient

  console.log 'Aura::Gallery initialized!'
  Meteor.subscribe 'auraGallery'

  initial = true
  Tracker.autorun ->
    console.log 'tracker runned'
    if AuraGallery.findOne()
      if initial
        Session.set 'auraGalleryCurrentAlbum', AuraGallery.findOne()._id
        initial = false

  Tracker.autorun ->
    if AuraGallery.findOne()
      Session.set 'auraGalleryCurrentPic', AuraGallery.findOne({'_id': Session.get('auraGalleryCurrentAlbum')}).pics[0]


  Template.registerHelper 'auraGalleryListAlbums', ->
    AuraGallery.find()

  Template.registerHelper 'auraGalleryCurrentAlbum', ->
    if Session.get('auraGalleryCurrentAlbum')
      console.log Session.get('auraGalleryCurrentAlbum')
      AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum'))

  Template.registerHelper 'auraGalleryCurrentPic', ->
    Session.get 'auraGalleryCurrentPic'

  Template.registerHelper 'auraGalleryGetThumb', (pic)->
    if pic
      pic.split('.')[0] + '_thumb.' + pic.split('.')[1]

  Meteor.startup ->

    $('body').on 'click', '[data-gallery-album-target]', (e)->
      console.log 'changing album'
      target = $(e.currentTarget).data('gallery-album-target')
      console.log target
      Session.set('auraGalleryCurrentAlbum', target)

    $('body').on 'click', '[data-gallery-pic-target]', (e)->
      console.log 'changing album'
      target = $(e.currentTarget).data('gallery-pic-target')
      console.log target
      Session.set('auraGalleryCurrentPic', target)

    $('body').on 'click', '#auraGalleryNextPic', ->
      picIndex = do ->
        _.each AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum')).pics, (pic, index)->
          console.log pic
          console.log index
          console.log Session.get('auraGalleryCurrentPic')
          if _.isEqual(pic, Session.get('auraGalleryCurrentPic'))
            return index
      console.log picIndex
      Session.set('auraGalleryCurrentPic', AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum')).pics[picIndex + 1])



if Meteor.isServer

  console.log 'Aura::Gallery initialized!'
  Meteor.publish 'auraGallery', ->
    AuraGallery.find()







  #Seed

  if AuraGallery.find().count() is 0

    AuraGallery.insert {

      pics: ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg']
      titlePic: '1.jpg'
      title: 'Фотосессия'
      desc: 'Классная фотосессия для маленьких принцесс'
      date: Date.parse(new Date())

    }

    AuraGallery.insert {

      pics: ['11.jpg', '12.jpg', '13.jpg', '14.jpg', '15.jpg']
      titlePic: '11.jpg'
      title: 'Еще событие'
      desc: 'Классная фотосессия для маленьких принцесс'
      date: Date.parse(new Date())

    }