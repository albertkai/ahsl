Router.map ->

  @route 'blogPage', {
    path: 'blog/:alias'
    template: 'blogPage'
    layoutTemplate: 'innerLayout'
    waitOn: ->
      Meteor.subscribe 'blog'
    data: ->
      Blog.findOne({alias: @params.alias})
    action: ->
      if @ready()
        @render()
  }

  @route 'bloglist', {
    path: 'bloglist'
    layoutTemplate: 'innerLayout'
    template: 'blog'
    waitOn: ->
      [Meteor.subscribe('blog'), Meteor.subscribe('blogTags')]
  }



if Meteor.isClient


  Meteor.subscribe 'blog'
  Meteor.subscribe 'blogTags'
  Meteor.subscribe 'blogCategories'

  Session.set 'auraBlogListCategory', 'all'
  Session.set 'auraBlogListSort', 'date'

  Template.registerHelper 'blogList', ->

    category = Session.get('auraBlogListCategory')
    sortField = Session.get('auraBlogListSort')
    sortQuery = {}
    query = do ->
      if category is 'all'
        {}
      else
        {category: category}
    sortQuery[sortField] = 1

    Blog.find(query, sortQuery)

  Template.registerHelper 'blogCategories', ->

    BlogCategories.find()

  Template.registerHelper 'getBlogDate', (date)->

    moment(date).format('DD.MM.YYYY')

  Template.blogCreateModal.rendered = ->

    Meteor.defer ->
      @.$('#blog-create-modal').addClass '_opened'
    @.$('select').select2({
      minimumResultsForSearch: -1
    })


  Meteor.startup ->

    $('body').on 'click', '[data-goto-blog-page]', (e)->

      console.log $(e.target)
      if $(e.target).parent('.remove').length is 0
        alias = $(e.currentTarget).data('alias')
        Router.go 'blogPage', {alias: alias}


    $('body').on 'click', '[data-aura-blog-remove-tag]', (e)->

      tagId = $(e.currentTarget).closest('[data-tag-id]').data('tag-id')
      recordId = $(e.currentTarget).closest('[data-aura-with]').data('aura-with')
      Meteor.call 'removeTagFromRecord', recordId, tagId, (err, res)->
        if err then console.log err

    $('body').on 'click', '[data-aura-blog-next]', (e)->

      currentId = $(e.currentTarget).closest('[data-aura-with]').data('aura-with')
      BlogCtrl.nextRecord(currentId)

    $('body').on 'click', '[data-aura-blog-prev]', (e)->

      currentId = $(e.currentTarget).closest('[data-aura-with]').data('aura-with')
      BlogCtrl.prevRecord(currentId)

    $('body').on 'keypress', '#aura-blog-add-tag', (e)->

      if e.which is 13

        id = $(e.currentTarget).closest('[data-aura-with]').data('aura-with')

        if BlogTags.findOne({name: $(e.currentTarget).val()})

          tagId = BlogTags.findOne({name: $(e.currentTarget).val()})._id
          if !_.contains Blog.findOne({_id: id}).tags, BlogTags.findOne({name: $(e.currentTarget).val()})._id
            Meteor.call 'incrementBlogTagCount', $(e.currentTarget).val(), (err, res)->
              if err
                console.log err
              else
                Meteor.call 'addTagToRecord', id, res, (error, resp)->
                  if error
                    console.log error
                  else
                    $(e.target).val('')

          else

            Aura.notify 'Такой тег уже добавлен!'
            $(e.target).val('')

        else

          Meteor.call 'createBlogTag', $(e.currentTarget).val(), (err, res)->

            if err
              console.log err
            else
              Meteor.call 'addTagToRecord', id, res, (error, resp)->
                if error
                  console.log error
                else
                  $(e.target).val('')



    $('body').on 'click', '[data-add-new-blog-page]', (e)->

      if !BlogCtrl.addModalTemplate
        BlogCtrl.addModalTemplate = Blaze.render Template.blogCreateModal, document.body
      else
        $('#blog-create-modal').addClass('_opened')

    $('body').on 'click', '#blog-create-modal button', (e)->
      input = $('#blog-create-modal').find('input').val()
      select = $('#blog-create-modal').find('select').val()
      if input and input isnt ''
        if !Blog.findOne({alias: input})
          if !input.split(' ')[1]
            $('#blog-create-modal').removeClass '_opened'
            Meteor.setTimeout ->
              BlogCtrl.addRecord input, select
            , 400
          else
            Aura.notify 'Ссылка должна быть сплошной строкой без пробелов=('
        else
          Aura.notify 'Запись с таким именем уже существует=('
      else
        Aura.notify 'Пожалуйста введите название ссылки на статью'

    $('body').on 'click', '.blog-cont .item .remove', (e)->
      alias = $(e.currentTarget).closest('[data-alias]').data('alias')
      (new PNotify({
        title: 'Удалить запись?',
        text: 'Возможности восстановить ее уже не будет',
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

        Meteor.call 'removeRecord', alias, (err, res)->
          if err
            console.log err
          else
            Aura.notify 'Запись удалена'

      )

    $('body').on 'click', '#blog-create-modal .remove', (e)->

      $('#blog-create-modal').removeClass '_opened'



  BlogCtrl = {

    addModalTemplate: null

    addRecord: (alias, category)->

      console.log 'adding blog record'

      Meteor.call 'addRecord', alias, category, (err, res)->

        if err
          console.log err

        else
          Router.go 'blogPage', {
            alias: res
          }


    nextRecord: (currentId)->

      blogList = Blog.find().fetch()
      length = blogList.length
      index = 0
      nextId = ''
      blogList.forEach (b)->
        if b._id is currentId
          if index + 1 > length
            nextId = blogList[0]._id
          else
            nextId = blogList[index + 1]._id
        index++
      console.log nextId
      nextRecordAlias = Blog.findOne({_id: nextId}).alias
      Router.go 'blogPage', {alias: nextRecordAlias}

    prevRecord: (currentId)->

      blogList = Blog.find().fetch()
      index = 0
      prevId = ''
      blogList.forEach (b)->
        if b._id is currentId
          if index - 1 < 0
            prevId = _.last(blogList)._id
          else
            prevId = blogList[index - 1]._id
        index++
      console.log prevId
      prevRecordAlias = Blog.findOne({_id: prevId}).alias
      Router.go 'blogPage', {alias: prevRecordAlias}


  }










if Meteor.isServer


  Meteor.methods {

    addRecord: (alias, category)->

      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

        Blog.insert {

          alias: alias
          pic: null
          title: 'Ваш заголовок'
          date: Date.parse(new Date())
          shortDesc: 'Краткое описание'
          html: '<p>Напишите что-нибудь=)</p>'
          tags: null

        }

        alias

      else

        console.log 'permission denied'

    removeRecord: (alias)->

      Blog.remove {'_id': Blog.findOne({alias: alias})._id}


    addTagToRecord: (id, tag)->

      console.log 'adding tag to record'
      Blog.update {_id: id}, {$push: {tags: tag}}

    createBlogTag: (name)->
      console.log 'creating auraBlog tag with name: ' + name
      BlogTags.insert {
        name: name
        count: 1
      }

    incrementBlogTagCount: (name)->
      console.log 'incrementing auraBlog tag: ' + name
      BlogTags.update {'name': name}, {$inc: {count: 1}}
      BlogTags.findOne({'name': name})._id

    removeTagFromRecord: (recordId, tagId)->
      Blog.update {_id: recordId}, {$pull: {tags: tagId}}
      if BlogTags.findOne({_id: tagId}).count > 1
        BlogTags.update {_id: tagId}, {$inc: {count: -1}}
      else
        BlogTags.remove {_id: tagId}






  }

  Meteor.publish 'blog', ->
    Blog.find()

  Meteor.publish 'blogTags', ->
    BlogTags.find()

  Meteor.publish 'blogCategories', ->
    BlogCategories.find()

  Meteor.startup ->

#    if Blog.find().count() > 0
#      Blog.find().fetch().forEach (b)->
#        Blog.remove b._id

    if Blog.find().count() is 0

      Blog.insert {

        alias: 'new-record'
        pic: 'blog_bg.jpg'
        title: 'Новая классная статья в блоге'
        date: Date.parse(new Date())
        shortDesc: 'Это короткое описание статьи, его надо заполнять отдельно'
        html: '<p>Новая статья, очень круто и весело, нам все нравится и мы получаем удовольствие. Очень много классного текста, еще больше, еще бооооольше</p><p class="inline-quot">Это цитата, ее можно вставлять в текст динамически, достаточно симпатично смотрится и привлекает внимание, с ее помощью можно выделять важные элементы</p><p>Как же все таки круто нахлдиться в теплой компании, например на Рождество или Новый год, где-нибудь на курорте или что-нибудь такое.</p><img class="aura-float-left" src="http://d1tvqt3gjtui5j.cloudfront.net/images/bal.jpg" data-aura-image-embed alt=""/><p>Это текст для обкатывания того, чтобы посмотреть как картинка выглядит прямо в тексте, вроде непохо.</p>'
        tags: []
      }

      Blog.insert {

        alias: 'new-record-again'
        pic: 'blog_bg.jpg'
        title: 'Новая классная статья в блоге'
        date: Date.parse(new Date())
        shortDesc: 'Это короткое описание статьи, его надо заполнять отдельно'
        html: '<p>Новая статья, очень круто и весело, нам все нравится и мы получаем удовольствие</p><p>Как же все таки круто нахлдиться в теплой компании</p>'
        tags: []
      }

      Blog.insert {

        alias: 'new-record-yeeeah'
        pic: 'blog_bg.jpg'
        title: 'Новая классная статья в блоге'
        date: Date.parse(new Date())
        shortDesc: 'Это короткое описание статьи, его надо заполнять отдельно'
        html: '<p>Новая статья, очень круто и весело, нам все нравится и мы получаем удовольствие</p><p>Как же все таки круто нахлдиться в теплой компании</p>'
        tags: []
      }

#    if BlogTags.find().count() > 0
#
#      BlogTags.find().fetch().forEach (t)->
#        BlogTags.remove {'_id': t._id}


    if BlogCategories.find().count() > 0
      BlogCategories.find().fetch().forEach (b)->
        BlogCategories.remove b._id

    if BlogCategories.find().count() is 0

      BlogCategories.insert {
        name: 'Школа'
      }

      BlogCategories.insert {
        name: 'События'
      }

      BlogCategories.insert {
        name: 'Обучение'
      }

#    if BlogTags.find().count() is 0
#
#      BlogTags.insert {
#
#        name: 'школа'
#        count: 1
#
#      }
#
#      BlogTags.insert {
#
#        name: 'известные люди'
#        count: 2
#
#      }
#
#      BlogTags.insert {
#
#        name: 'этикет'
#        count: 3
#
#      }
#
#      BlogTags.insert {
#
#        name: 'саморазвитие'
#        count: 3
#
#      }
#
#      BlogTags.insert {
#
#        name: 'интересное'
#        count: 2
#
#      }
#
#      BlogTags.insert {
#
#        name: 'мероприятие'
#        count: 2
#
#      }
#
#      BlogTags.insert {
#
#        name: 'фотоотчет'
#        count: 2
#
#      }