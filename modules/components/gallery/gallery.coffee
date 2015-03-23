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
      console.log 'tracker 2 runed'
      Session.set 'auraGalleryCurrentPic', AuraGallery.findOne({'_id': Session.get('auraGalleryCurrentAlbum')}).pics[0]
#      $.scrollTo('.pic-container', 600, {offset: -70})
      Gallery.countPreviewTape()


  Template.registerHelper 'auraGalleryListAlbums', ->
    AuraGallery.find({}, {sort: {order: 1}})

  Template.registerHelper 'auraGalleryCurrentAlbum', ->
    if Session.get('auraGalleryCurrentAlbum')
      console.log Session.get('auraGalleryCurrentAlbum')
      AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum'))


  Template.registerHelper 'auraGalleryCurrentPic', ->
    $('<img>').attr('src', 'http://d1tvqt3gjtui5j.cloudfront.net/gallery/' + Session.get('auraGalleryCurrentPic')).on 'load', ->
      $('.main-pic').find('.spinner-container').removeClass '_visible'
      $('.pic-container').addClass '_visible'
    Session.get 'auraGalleryCurrentPic'

  Template.registerHelper 'auraGalleryGetThumb', (pic)->
    if pic
      pic.split('.')[0] + '_thumb.' + pic.split('.')[1]

  Template.registerHelper 'getFirstPicThumb', (pics)->
    pic = _.first pics
    pic.split('.')[0] + '_thumb.' + pic.split('.')[1]




  Meteor.startup ->

    $('body').on 'click', '[data-gallery-album-target]', (e)->
      console.log 'changing album'
      if $(e.currentTarget).data('gallery-album-target') isnt Session.get('auraGalleryCurrentAlbum')
        target = $(e.currentTarget).data('gallery-album-target')
        console.log target
        $('.main-pic').find('.spinner-container').addClass '_visible'
        $('.pic-container').removeClass '_visible'
        Session.set('auraGalleryCurrentAlbum', target)
      else
        $.scrollTo('.pic-container', 600, {offset: -70})


    $('body').on 'click', '[data-gallery-toggle-modal]', ->

      console.log 'gallery admin rendered'

      if Gallery.galleryEditModal
        $('#galleryEditModal').addClass '_opened'
      else
        Gallery.galleryEditModal = Blaze.renderWithData Template.galleryEditModal, {itemList: AuraGallery.find({}, {sort: {order: 1}})} , document.body

    $('body').on 'click', '[data-gallery-pic-target]', (e)->
      console.log 'changing pic'
      if $(e.currentTarget).data('gallery-pic-target') isnt Session.get('auraGalleryCurrentPic')
        target = $(e.currentTarget).data('gallery-pic-target')
        console.log target
        $('.main-pic').find('.spinner-container').addClass '_visible'
        $('.pic-container').removeClass '_visible'
        Session.set('auraGalleryCurrentPic', target)
        $(e.currentTarget).addClass('_active').siblings().removeClass '_active'

    $('body').on 'click', '#auraGalleryNextPic', ->
      length = AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum')).pics.length
      $('.main-pic').find('.spinner-container').addClass '_visible'
      $('.pic-container').removeClass '_visible'
      picIndex = do ->
        if $('.carousel-container').find('div._active').length > 0
          index = $('.carousel-container').find('div._active').index()
          if index + 1 >= length
            $('.carousel-container').find('div._active').removeClass('_active')
            $('.carousel-container').find('div').first().addClass('_active')
            0
          else
            index + 1
            $('.carousel-container').find('div._active').removeClass('_active').next().addClass('_active')
            $('.carousel-container').find('div._active').index()
        else
          $('.carousel-container').find('div').first().next().addClass('_active')
          1
      Session.set('auraGalleryCurrentPic', AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum')).pics[picIndex])

    $('body').on 'click', '#auraGalleryPrevPic', ->
      length = AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum')).pics.length
      $('.main-pic').find('.spinner-container').addClass '_visible'
      $('.pic-container').removeClass '_visible'
      picIndex = do ->
        if $('.carousel-container').find('div._active').length > 0
          index = $('.carousel-container').find('div._active').index()
          if index - 1 < 0
            $('.carousel-container').find('div._active').removeClass('_active')
            $('.carousel-container').find('div').last().addClass('_active')
            $('.carousel-container').find('div').last().index()
          else
            index - 1
            $('.carousel-container').find('div._active').removeClass('_active').prev().addClass('_active')
            $('.carousel-container').find('div._active').index()
        else
          $('.carousel-container').find('div').last().addClass('_active')
          $('.carousel-container').find('div').last().index()
      Session.set('auraGalleryCurrentPic', AuraGallery.findOne('_id': Session.get('auraGalleryCurrentAlbum')).pics[picIndex])


  Template.galleryEditModal.events {

    'click aside li': (e)->
      id = $(e.currentTarget).data('id')
      Session.set 'auraModalList', id
      $(e.currentTarget).addClass('_active').siblings().removeClass('_active')
      if Gallery.currentEditModalAlbum
        Blaze.remove Gallery.currentEditModalAlbum
      console.log AuraGallery.findOne({_id: id})
      Gallery.currentEditModalAlbum = Blaze.renderWithData Template.galleryEditModalAlbum, AuraGallery.findOne({_id: id}), $('#galleryEditModal').find('.list-wrap').get(0)

    'click aside li .delete': (e)->
      clicked = $(e.target).closest('li')
      id = clicked.data('id')
      images = AuraGallery.findOne({'_id': id}).pics
      thumbs = images.map (i)->
        i.split('.')[0] + '_thumb.' + i.split('.')[1]
      images = images.concat thumbs
      order = parseInt clicked.data('order'), 10
      console.log images
      (new PNotify({
        title: 'Удалить целый альбом?',
        text: 'Все фотографии этого альбома будут удалены с хостинга',
        hide: false,
        addclass: 'aura-notify'
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

        Meteor.call 'deletePics', images, 'ahsl2/gallery', (err, res)->
          if err

            Aura.notify 'Изображения не удалены:( Может и к лучшему))'

          else

            if res

              AuraGallery.remove id
              Aura.notify 'Альбом удален!'
              $(e.target).closest('ul').find('li').first().trigger('click')

              AuraGallery.find({order: {$gt: order}}).fetch().forEach (album)->
                newOrder = album.order - 1
                id = album._id
                AuraGallery.update id, {$set: {order: newOrder}}

            else

              Aura.notify 'Изображения не удалены:( Ошибка на стороне сервера'

      ).on('pnotify.cancel', ->
        console.log 'deletion canceled'
      )


    'click aside .add-new': (e)->

      AuraGallery.find().fetch().forEach (album)->
        newOrder = album.order + 1
        console.log newOrder
        AuraGallery.update album._id, {$set: {order: newOrder}}

      AuraGallery.insert {
        order: 0,
        pics: [],
        title: 'Новый альбом'
        desc: 'Описание альбома'
        date: Date.parse(new Date())
      }, (id)->
        Meteor.setTimeout ->
          $(e.target).siblings('ul').find('li').first().trigger('click')
        , 300

  }

  Template.galleryEditModal.rendered = ->

    console.log 'rendering gallery admin'

    Meteor.defer ->

      $('#galleryEditModal').addClass '_opened'

      $('#galleryEditModal').find('#gallery-albums-list').sortable({
        stop: (e, ui)->
          Gallery.reorderAlbums()
      })

      $('#galleryEditModal').find('#gallery-albums-list').find('li').first().trigger('click')


  Template.galleryEditModalAlbum.rendered = ->

    $("#gallery-items-thumbs").sortable({
      stop: (e, ui)->
        Gallery.reorderPics()
    })


  Template.galleryEditModalAlbum.helpers {

    getThumb: (pic)->

      pic.split('.')[0] + '_thumb.' + pic.split('.')[1]

  }

  Template.galleryEditModalAlbum.events {

    'change .add input[type="file"]': (e)->
      console.log 'triggered change'
      input = $(e.target)
      file = input.get(0).files[0]
      console.log input.get(0).files[0]
      id = $('#albumId').val()
      fr = new FileReader()
      NProgress.start()
      Aura.media.resizeAndUpload id, file, (res)->

        albumId = $('#albumId').val()
        AuraGallery.update {_id: albumId}, {$push: {pics: res}}, ->

          NProgress.done()
          $('#galleryEditModal').find('#gallery-albums-list').find('li._active').trigger('click')
          Aura.notify 'Изображение добавлено!'

    'dragover .list-cont': (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).addClass('_hover')
      return false

    'dragenter .list-cont': (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).addClass('_hover')
      return false

    'dragleave .list-cont': (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).removeClass('_hover')
      return false

    'drop .list-cont': (e)->
      e.preventDefault()
      console.log 'triggering multiple upload'

      uploaded = false
      albumId = $('#albumId').val()
      length = e.originalEvent.dataTransfer.files.length

      console.log length

      NProgress.start()

      for i in [0...length]

        console.log 'Загружаем ' + (i + 1) + ' файл из ' + length

        Aura.media.resizeAndUpload albumId, e.originalEvent.dataTransfer.files[i], (res)->

          AuraGallery.update {_id: albumId}, {$push: {pics: res}}, ->

            console.log 'изображение ' + res + ' загружено'

            if i + 1 >= length
              NProgress.done()
              $('#galleryEditModal').find('#gallery-albums-list').find('li._active').trigger('click')
              Aura.notify 'Все изображения загружены'



    'click #gallery-items-thumbs li .delete': (e)->
      clicked = $(e.target).closest('li')
      id = $('#albumId').val()
      image = _.last(clicked.find('.img').css('background-image').split('/')).replace(')', '')
      thumb = image.split('.')[0] + '_thumb.' + image.split('.')[1]
      console.log image
      Meteor.call 'deletePics', [image, thumb], 'ahsl2/gallery', (err, res)->
        if err

          Aura.notify 'Изображение не удалено:( Может и к лучшему))'

        else

          if res

            clicked.remove()
            images = []
            $('#galleryEditModal').find('.list-cont li.item').each ->

              if !$(this).hasClass('ui-sortable-placeholder')
                img = $(this).find('.img').css('background-image').split('/')
                name = _.last(img).replace(')', '')
                ext = _.last(name.split('.'))
                origName = _.first(name.split('.')[0].split('_'))
                images.push(origName + '.' + ext)
            AuraGallery.update id, {$set: {'pics': images}}
            Aura.notify 'Изображение удалено!'

          else

            Aura.notify 'Изображение не удалено:( Ошибка на стороне сервера'

  }


  @Gallery = {

    galleryEditModal: null
    currentEditModalAlbum: null

    countPreviewTape: ->

      width = 116
      length = AuraGallery.findOne({'_id': Session.get('auraGalleryCurrentAlbum')}).pics.length
      $('.list-pics').find('.carousel-container').width(length * width)

    reorderAlbums: ->

      newOrder = []

      $('#galleryEditModal').find('aside li').each ->
        obj = {
          id: $(this).data('id')
          index:$(this).index()
        }
        newOrder.push obj

      newOrder.forEach (item)->
        console.log 'updating ' + item.id
        AuraGallery.update {'_id': item.id}, {$set: {'order': item.index}}

      console.log 'albums reordered'

    reorderPics: ->

      reordered = []
      id = $('#albumId').val()

      $('#galleryEditModal').find('.list-cont li.item').each ->

        if !$(this).hasClass('ui-sortable-placeholder')
          img = $(this).find('.img').css('background-image').split('/')
          name = _.last(img).replace(')', '').replace('"', '')
          ext = _.last(name.split('.'))
          origName = _.first(name.split('.')[0].split('_'))
          reordered.push(origName + '.' + ext)

      console.log reordered

      AuraGallery.update {_id: id}, {$set: {'pics': reordered}}, ->

        $('.carousel-cont').find('[data-id="' + id + '"]').trigger('click')

      console.log 'reordered'

  }



if Meteor.isServer

  console.log 'Aura::Gallery initialized!'
  Meteor.publish 'auraGallery', ->
    AuraGallery.find()







  #Seed

#  if AuraGallery.find().count() > 0
#
#    AuraGallery.find().fetch().forEach (a)->
#      AuraGallery.remove {_id: a._id}

  if AuraGallery.find().count() is 0

    AuraGallery.insert {

      pics: ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg']
      titlePic: '1.jpg'
      title: 'Фотосессия'
      desc: 'Классная фотосессия для маленьких принцесс'
      date: Date.parse(new Date())
      order: 1

    }

    AuraGallery.insert {

      pics: ['11.jpg', '12.jpg', '13.jpg', '14.jpg', '15.jpg']
      titlePic: '11.jpg'
      title: 'Еще событие'
      desc: 'Классная фотосессия для маленьких принцесс'
      date: Date.parse(new Date())
      order: 2

    }