
if Meteor.isClient

  console.log 'aura is working'

  Session.setDefault 'admin.editMode', false

  Template.auraAdminPanel.helpers {
    history: ->
      History.find({}, {sort: {date: -1}})
    getDate: (date)->
      moment(date).lang('ru').format('DD.MM.YYYY HH:MM')
  }

  Template.auraAdminPanel.events {

    'click #toggle-users': ->

      $('#auraUsersModal').addClass '_opened'
  }

  Meteor.subscribe 'users'
  Meteor.subscribe 'auraPages'
  Meteor.subscribe 'auraHistory'

#  Template.body.helpers {
#    common: ->
#      AuraPages.findOne({name: 'common'})
#  }


  #Regestering helpers

  Template.registerHelper 'common', ->
    AuraPages.findOne({name: 'common'})

  Template.registerHelper 'index', ->
    AuraPages.findOne({name: 'index'})

  Template.registerHelper 'contacts', ->
    AuraPages.findOne({name: 'contacts'})

  Template.registerHelper 'children', ->
    AuraPages.findOne({name: 'children'})

  Template.registerHelper 'teens', ->
    AuraPages.findOne({name: 'teens'})

  Template.registerHelper 'lateTeens', ->
    AuraPages.findOne({name: 'lateTeens'})

  Template.registerHelper 'grownUps', ->
    AuraPages.findOne({name: 'grownUps'})

  Template.registerHelper 'news', ->
    AuraPages.findOne({name: 'news'})

  Template.registerHelper 'eventsList', ->
    AuraPages.findOne({name: 'events'})

  Template.registerHelper 'storagePath', ->
    'http://d1tvqt3gjtui5j.cloudfront.net'

  Meteor.startup ->

    $(window).on 'blur', ->

      console.log 'blured'

    $('body').on 'click', '.close-modal', ->

      $('.auraModal').removeClass '_opened'

    $('body').on 'mouseenter', '[data-aura-html][contenteditable="true"]', (e)->

      target = $(e.currentTarget)
      target.addClass('_editor-hover')
      Meteor.setTimeout ->
        target.removeClass('_editor-hover')
      , 600



    Deps.autorun ->
      console.log 'session worked!'
      if Session.get('admin.editMode') is true
        $('[contenteditable]').each ->
          $(this).attr('contenteditable', 'true')
      else
        $('[contenteditable]').each ->
          $(this).attr('contenteditable', 'false')


    $('body').on 'click', '.logout', ->

      Meteor.logout()

    $('body').find('.aura-toggle-edit').on 'click', (e)->
      console.log 'changed'
      console.log $(e.currentTarget)
      $(e.currentTarget).toggleClass('_active')
      if $(e.currentTarget).hasClass('_active')
        Session.set 'admin.editMode', true
        $(e.currentTarget).find('p').text('правка')
      else
        Session.set 'admin.editMode', false
        $(e.currentTarget).find('p').text('просмотр')


    Mousetrap.bind 'q w e', (e)->
      Aura.showAdminModal()

    Mousetrap.bind 'й ц у', (e)->
      Aura.showAdminModal()

    Template.auraAdminPanel.events {

      'click #edit-mode': (e)->
        if $(e.target).is(':checked')
          Session.set('admin.editMode', true)
          aloha.dom.query('[data-aura-html]', document).forEach(aloha)
        else
          Session.set('admin.editMode', false)
          aloha.dom.query('[data-aura-html]', document).forEach(aloha.mahalo)

      'mouseenter #history-cont li': (e)->
#        path = $(e.target).data('selector-path')
#        if $(path).length > 0
#          $(path).addClass('_focus')
#          Meteor.setTimeout ->
#            if $(e.target).is(':hover')
#              $.scrollTo $(path), 500, {offset: -150}
#          , 500

      'click #history-cont li': (e)->
        target = $(e.target).closest('li').data('id')
        Aura._historyRestore(target)
    }

    Template.aura.rendered = ->

      script = document.createElement("script")
      script.type = "text/javascript"
      script.src = '/scripts/ace.js'
      script.id = "ace-script"
      document.body.appendChild(script)
      $('#ace-script').load ->
        console.log ace


    Template.aura.events {
      'click .close span': ->
        console.log 'closing'
        Aura.hideAdminModal()

    }


    Template.auraLoginModal.events {

      'click .close': ->

        Aura.hideAdminModal()

      'click #login': (e)->

        e.preventDefault()
        email = $('#login-email').val()
        password = $('#login-password').val()
        Meteor.loginWithPassword email, password, ->
          Aura.hideAdminModal()

    }


    Template.auraUsersModal.rendered = ->

      $('#aura-users-cont > ul > li').first().trigger('click')


    Template.auraUsersModal.helpers {

        allUsers: ->
          Meteor.users.find()

        getPermissions: (roles)->

          if roles

            role = roles[0]
            if role is 'admin'
              'администратор'
            else if role is 'owner'
              'владелец'

        isNewUser: ->

          if Session.get('auraSelectedUser') is 'new'
            true
          else
            false


        getImage: (pic)->

          if pic
            "background-image: url(http://d1tvqt3gjtui5j.cloudfront.net/aura/" + pic + ")"
          else
            ''

        selectedUser: ->

          id = Session.get 'auraSelectedUser'
          Meteor.users.findOne({'_id': id})

      }

    Template.auraUsersModal.events {

      'click #aura-users-cont > ul > li': (e)->

        if $(e.currentTarget).hasClass('add-user')

          Session.set('auraSelectedUser', 'new')

        else

          id = $(e.currentTarget).data('id')
          $(e.currentTarget).addClass('_active').siblings().removeClass('_active')
          Session.set('auraSelectedUser', id)

      'click .remove': (e)->

        id = $(e.currentTarget).closest('li').data('id')

        Meteor.call 'auraRemoveUser', id, (err, res)->

          if err

            Aura.notify 'Пользователь не удален, обратитесь к разработчику'

          else

            Aura.notify 'Пользователь удален!'

    }

    Template.auraNewUser.events {

      'click #create-user': ->

        if $('#user-name').val() isnt '' and $('#user-surname').val() isnt '' and $('#user-email').val() isnt '' and $('#user-password').val() isnt ''
          options = {
            name: $('#user-name').val()
            surname: $('#user-surname').val()
            email: $('#user-email').val()
            password: $('#user-password').val()
            role: $('#permissions-select').val()
          }
          Meteor.call 'auraCreateUser', options, (err, res)->

            if err
              Aura.notify 'Упс, что-то не так на сервере:( Обратитесь к разработчику', 'error'

            else

              Aura.notify 'Ура, пользователь создан!', 'success'
              console.log res


    }

    Template.auraUsersModalSettings.rendered = ->

      $('.aura-select').select2('destroy')

      $('.aura-select').select2({
        minimumResultsForSearch: -1
      })

    Template.auraNewUser.rendered = ->

      $('.aura-select').select2('destroy')

      $('.aura-select').select2({
        minimumResultsForSearch: -1
      })

    Template.auraUsersModalSettings.helpers {

      getEmail: (emails)->
        emails[0].address

    }



    Template.auraEditor.rendered = ->

      console.log 'editor rendered'

#      editor.auraEditorHtml = ace.edit("editorHtml")
#      editor.auraEditorHtml.setTheme("ace/theme/monokai")
#      editor.auraEditorHtml.getSession().setMode("ace/mode/html")
#      editor.auraEditorHtml.on 'change', (e)->
##        value = editor.auraEditorHtml.getValue().replace(/\s+/g, ' ')
##        target = $('.editor').find('.html-cont').data('path')
##        console.log target
##        console.log value
##        $(target).html(value)
      $('.html-cont').on 'keyup', ->
        Meteor.setTimeout ->
          value = editor.auraEditorHtml.getValue().replace(/\s+/g, ' ')
          target = $('.editor').find('.html-cont').data('path')
          console.log target
          console.log value
          $(target).html(value)
        , 50

    Template.auraEditor.events {

      'click button': (e)->
        $(e.target).closest('button').toggleClass('_active')

      'click #b-html': (e)->
        if $(e.target).hasClass('_active')
          $('.editor .html-cont').css('visibility', 'visible').removeClass('flipOutX').addClass('animated flipInX')
          console.log 'this ' + editor._editingItem
        else
          $('.editor .html-cont').removeClass('flipInX').addClass('flipOutX')

      'click .editor .html-cont button': (e)->
        val = $('.editor .html-cont').data('resetData')
        editor.auraEditorHtml.setValue(val)

#      'input .editor .html-cont textarea': (e)->
#        path = $(e.target).data('path')
#        $(path).html($(e.target).val().trim())

      'blur .editor .html-cont textarea': (e)->
    #    index = $(e.target).data('index')
    #    html = $(e.target).val()
    #    console.log index
    #    console.log Aura._historyBuffer[index].newData
    #    Aura._historyBuffer[index].newData = html
    #    editor._changedBuffer[index].data = html
        $($(e.target).data('path')).trigger('blur')



      'click #b-bold': ->
        editor.commands.bold()

      'click #b-italic': ->
        editor.commands.italic()

      'click #b-sub': ->
        editor.commands.sub()

      'click #b-sup': ->
        editor.commands.sup()

      'click #b-ul': ->
        editor.commands.ul()

      'click #b-ol': ->
        editor.commands.ol()

      'click #b-h1': ->
        editor.commands.h1()

      'click #b-h2': ->
        editor.commands.h2()

      'click #b-h3': ->
        editor.commands.h3()

      'click #b-h4': ->
        editor.commands.h4()

      'click #b-h5': ->
        editor.commands.h5()

      'click #b-h6': ->
        editor.commands.h6()

      'click #b-span': ->
        editor.commands.span()

      'click #b-link': ->
        editor.commands.link()

      'click #b-save': (e)->


        editor.hideEditor()
        editor.save()

    }


if Meteor.isClient

  console.log 'visible'

  Meteor.startup ->

    PNotify.prototype.options.styling = "fontawesome"


    $('body').on 'dragover', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).addClass('_hover')
      return false

    $('body').on 'dragenter', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).addClass('_hover')
      return false

    $('body').on 'dragleave', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).removeClass('_hover')
      return false

    $('body').on 'drop', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', (e)->
      if Session.get('admin.editMode')
        console.log 'droped'
        e.preventDefault()
        e.stopPropagation()
        $(e.target).removeClass('_hover')
        NProgress.start()
        file = e.originalEvent.dataTransfer.files[0]
        fr = new FileReader()
  #      MainCtrl.showLoader()
        fr.onload = ->
          pic = {}
          pic['data'] = fr.result
          pic['name'] = file.name
          pic['size'] = file.size
          pic['type'] = file.type
          currentPic = do ->
            if $(e.currentTarget).data('aura-image-background') or $(e.currentTarget).data('aura-list-image-background') or $(e.currentTarget).data('aura-with-image-background')
              path = $(e.currentTarget).css('background-image')
              _.last(path.split('/')).replace(')', '')
            else
              path = $(e.currentTarget).attr('src')
              _.last path.split('/')
  #        target = $(e.target).closest('[data-image]').data('image-target') or 'img'
          (new PNotify({
            title: 'Удалить старое изображение?',
            text: 'Желательно удалять, чтобы не перегружать хостинг',
            hide: false,
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

            Aura.media.updatePic(e, pic, file, currentPic, 'ahsl2/images', false)
            console.log pic
            console.log file
            console.log currentPic

          ).on('pnotify.cancel', ->
            Aura.media.uploadPic(e, pic, file, 'ahsl2/images', false)
            console.log pic
            console.log file
            console.log currentPic
          )

        fr.readAsBinaryString(file)

#    $('body').on 'paste', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"]', (e)->
#      console.log 'pasted'
#      $el = $(e.target).closest('[contenteditable="true"]')
#      Meteor.setTimeout ->
#        text = $el.text()
#        console.log text
#        $el.html(text)
#      , 100

    $('body').on 'dragover', '[data-aura-image-embed]', (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).addClass('_hover')
      return false

    $('body').on 'dragenter', '[data-aura-image-embed]', (e)->
      if e.preventDefault then e.preventDefault()
      $(e.currentTarget).addClass('_hover')
      return false

    $('body').on 'dragleave', '[data-aura-image-embed]', (e)->
      $(e.currentTarget).removeClass('_hover')
      return false

    $('body').on 'drop', '[data-aura-image-embed]', (e)->
      if Session.get('admin.editMode')
        console.log 'droped'
        NProgress.start()
        e.preventDefault()
        e.stopPropagation()
        $(e.currentTarget).removeClass('_hover')
        file = e.originalEvent.dataTransfer.files[0]
        fr = new FileReader()
        #      MainCtrl.showLoader()
        path = $(e.currentTarget).attr('src')
        fr.onload = ->
          pic = {}
          pic['data'] = fr.result
          pic['name'] = file.name
          pic['size'] = file.size
          pic['type'] = file.type
          currentPic = do ->
            _.last path.split('/')
          Meteor.call 'deletePic', currentPic, 'ahsl2/images', (err, res)->
            if err
              console.log err
            else
              Meteor.call 'uploadPic', pic, 'ahsl2/images', (error, newPic)->
                NProgress.done()
                if error
                  console.log error
                else
                  $(e.currentTarget).attr('src', _.without(path.split('/'), _.last(path.split('/'))).join('/') + '/' + newPic)
                  $(e.currentTarget).closest('[contenteditable]').trigger('input')

        fr.readAsBinaryString(file)


    $('body').on 'focus', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"],  [data-aura-with-html][contenteditable="true"]', 'focus', (e)->

      console.log 'focused on element'
      e.stopImmediatePropagation()
      e.stopPropagation()
      data = $(e.currentTarget).html()
      markup = $.htmlClean(data, {format:true})
      editor.showEditor(markup)
      editor._trackChanges.currentValue = data
      editor.editingItem = data
      $('.editor .html-cont').data('resetData', markup)
      $('.editor .html-cont').data('path', $(e.target).closest('[contenteditable="true"]').getPath())


    $('body').on 'blur', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"],  [data-aura-with-html][contenteditable="true"]', (e)->

      console.log 'blurred'
      if !editor.blured
        currentState = $(e.currentTarget).html()
        if currentState isnt editor.editingItem

          $('.editor .html-cont textarea').data('index', Aura._historyBuffer.length)

          #Check the type of stuff and generate query params

          if $(e.currentTarget).data('aura-html')

            query = $(e.currentTarget).data('aura-html')
            document = query.split('.')[0]
            field = query.split('.').splice(1).join()

          else if $(e.currentTarget).data('aura-list-html')

            query = $(e.currentTarget).data('aura-list-html')
            list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list')
            index = $(e.currentTarget).closest('[data-aura-list-item]').index()
            document = list.split('.')[0]
            field = list.split('.')[1] + '.' + index + '.' + query
            console.log document
            console.log field
            console.log index

          else if $(e.currentTarget).data('aura-with-html')

            query = $(e.currentTarget).data('aura-with-html')
            withRule = $(e.currentTarget).closest('[data-aura-with]').data('aura-with')
            withQuery = do ->
              if withRule.split('.')
                withRule.split('.')[0]
              else
                withRule
            document = withQuery
            field = query


            console.log 'this is with'

          coll = do ->
            if $(e.currentTarget).parents('[data-aura-collection]').length > 0
              $(e.currentTarget).parents('[data-aura-collection]').data('aura-collection')
            else
              'auraPages'

          docIndex = do ->
            if $(e.currentTarget).parents('[data-aura-index]').length > 0
              $(e.currentTarget).parents('[data-aura-index]').data('aura-index')
            else
              'name'

          console.log 'indx'
          console.log docIndex
          console.log coll

          Aura._historyBuffer.push {
            field: field
            document: document
            collection: coll
            index: docIndex
            prevData: editor.editingItem
            newData: currentState
            selectorPath: $(e.currentTarget).getPath()
            type: 'html'
          }
          editor._changedBuffer.push {
            field: field
            document: document
            index: docIndex
            collection: coll
            data: currentState
          }
          console.log editor._changedBuffer
          console.log Aura._historyBuffer
          $(e.target).closest('[contenteditable="true"]').addClass('_changed')
          editor.blured = true
          Meteor.setTimeout ->
            editor.blured = false
          , 1000


    #Editor add image


    $('body').on 'click', '[data-aura-list-remove]', (e)->
      if Session.get('admin.editMode')
        index = $(e.currentTarget).closest('[data-aura-list-item]').index()
        list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list')
        document = list.split('.')[0]
        field = list.split('.')[1]
        object = AuraPages.findOne({name: document}).classes[index]
        Meteor.call 'removeListItem', document, field, object, (err, res)->
          if err then console.log err

    $('body').on 'click', '[data-aura-list-add]', (e)->
      if Session.get('admin.editMode')
        list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list')
        document = list.split('.')[0]
        field = list.split('.')[1]
        sample = AuraPages.findOne({name: document})[field][0]

        Meteor.call 'addListItem', document, field, sample, (err, res)->
          if err then console.log err


    $('body').on 'mouseenter', '[data-aura-image-background]', (e)->
       $(e.currentTaget).addClass('_hover')

    $('body').on 'mouseleave', '[data-aura-image-background]', (e)->
      $(e.currentTaget).removeClass('_hover')


    $('body').on 'click', '[data-aura-image-embed]', (e)->
      if Session.get('admin.editMode')
        id = do ->
          if $(e.currentTarget).hasClass('aura-float-left')
            'set-float-left'
          else if $(e.currentTarget).hasClass('aura-float-right')
            'set-float-right'
          else
            'set-centered'
        $(e.currentTarget).addClass('aura-image-highlight')
        top = $(e.currentTarget).offset().top - 60
        left = $(e.currentTarget).offset().left
        if $('.aura-image-embed-overlay').length is 0
          $('body').append('<div class="aura-image-embed-overlay"></div>')
          $('body').append(editor.imageEmbedEdit)
          $('.image-embed-edit').css('left', left + 'px').css('top', top + 'px')
          Meteor.setTimeout ->
            $('.image-embed-edit').addClass '_opened'
          , 100
          $('.image-embed-edit').find('#' + id).addClass '_active'

    $('body').on 'click', '.image-embed-edit button', (e)->
      $img = $('.aura-image-highlight')
      if !$(e.currentTarget).hasClass('remove')
        $(e.currentTarget).addClass('_active').siblings().removeClass('_active')
        target = $(e.currentTarget).data('class')
        $img.removeClass('aura-float-left').removeClass('aura-float-right').removeClass('aura-centered')
        $img.addClass(target)
        top = $img.offset().top - 60
        left = $img.offset().left
        Meteor.setTimeout ->
          $('.image-embed-edit').css('left', left + 'px').css('top', top + 'px')
        , 400
      else
        pic = _.last $img.attr('src').split('/')
        Meteor.call 'deletePic', pic, 'ahsl2/images', (err, res)->
          if err
            console.log err
          else
            $img.remove()
            $('.image-embed-edit').remove()
            $('.aura-image-embed-overlay').remove()
            $(e.currentTarget).closest('[contenteditable]').trigger('input')
            Aura.notify 'Изображение удалено!'


    $('body').on 'click', '.aura-image-embed-overlay', (e)->
      $('[data-aura-image-embed]').removeClass 'aura-image-highlight'
      $('.image-embed-edit').removeClass '_opened'
      Meteor.setTimeout ->
        $('.image-embed-edit').remove()
      , 400
      $(e.currentTarget).remove()


    $('body').on 'input','[data-aura-instant-input]', (e)->
      if Aura.inputInstantTimeout
        clearTimeout Aura.inputInstantTimeout
      Aura.inputInstantTimeout = Meteor.setTimeout =>
        query = $(e.currentTarget).data('aura-instant-input').split('.')
        value = $(e.currentTarget).val()
        item = {}
        item['collection'] = query[0]
        item['document'] = query[1]
        item['index'] = '_id'
        query.shift()
        query.shift()
        item['field'] = query
        item['data'] = do ->
          if $(e.currentTarget).attr('type') is 'date'
            Date.parse(new Date(value))
          else if $(e.currentTarget).attr('id') is 'aura-alias-input'
            value
        Meteor.call 'saveHtml', item, (err, res)->
          if err
            console.log err
          else
            Aura.notify 'Изменения сохранены!'
            if $(e.currentTarget).attr('id') is 'aura-alias-input'
              Router.go Router.current().route.getName(), {alias: value}
      , 1500


    Template.body.events {

      'focus [data-aura-html][contenteditable="true"]': (e)->
        console.log 'focused'
        data = $(e.currentTarget).html()
        markup = $.htmlClean(data, {format:true})
        editor.showEditor(markup)
        editor._trackChanges.currentValue = data
        editor.editingItem = data
        $('.editor .html-cont').data('resetData', markup)
        $('.editor .html-cont').data('path', $(e.target).closest('[contenteditable="true"]').getPath())

      'input [contenteditable="true"]': (e)->
        markup = $(e.target).html()
        editor.auraEditorHtml.setValue($.htmlClean(markup, {format:true}))

      'click #admin-login-modal .close': ->
        Aura.hideAdminModal()

      'submit #aura-login-form': (e)->
        e.preventDefault()
        email = $('#aura-login-form').find('#email').val()
        password = $('#aura-login-form').find('#password').val()
        Meteor.loginWithPassword email, password, (err)->
          if err
            Aura.notify 'Ошибочка:('
          else
            Aura.notify 'Добро пожаловать!'
            Aura.hideAdminModal()
        false

      'blur [data-aura-html][contenteditable="true"]': (e)->
        console.log 'blurred'
        if !editor.blured
          currentState = $(e.currentTarget).html()
          if currentState isnt editor.editingItem
            query = $(e.target).data('aura-html')
            $('.editor .html-cont textarea').data('index', Aura._historyBuffer.length)
            document = query.split('.')[0]
            field = query.split('.').shift().join()

            Aura._historyBuffer.push {
              field: field
              document: document
              prevData: editor.editingItem
              newData: currentState
              selectorPath: $(e.currentTarget).getPath()
              type: 'html'
            }
            editor._changedBuffer.push {
              field: field
              document: document
              data: currentState
            }
            console.log editor._changedBuffer
            console.log Aura._historyBuffer
            $(e.target).closest('[contenteditable="true"]').addClass('_changed')
            editor.blured = true
            Meteor.setTimeout ->
              editor.blured = false
            , 1000

      'change .aura-edit-image input[type="file"]': (e)->
        input = $(e.target)
        file = input.get(0).files[0]
        fr = new FileReader()
        MainCtrl.showLoader()
        fr.onload = ->
          pic = {}
          pic['data'] = fr.result
          pic['name'] = file.name
          pic['size'] = file.size
          pic['type'] = file.type
          currentPic = do ->
            if $(e.target).closest('[data-image]').data('image-target') is 'background'
              path = $(e.target).closest('[data-image]').css('background-image')
              _.last(path.split('/')).replace(')', '')
            else
              path = $(e.target).closest('[data-image]').attr('src')
              _.last path.split('/')
          target = $(e.target).closest('[data-image]').data('image-target') or 'img'
          (new PNotify({
            title: 'Удалить старое изображение?',
            text: 'Желательно удалять, чтобы не перегружать хостинг',
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

            Aura.media.updatePic(e, pic, file, target, currentPic)

          ).on('pnotify.cancel', ->
            Aura.media.uploadPic(e, pic, file, target)
          )

        fr.readAsBinaryString(file)

      'change .auraModal .list-cont .add input[type="file"]': (e)->
        console.log 'triggered change'
        input = $(e.target)
        file = input.get(0).files[0]
        id = $('#albumId').val()
        fr = new FileReader()
        MainCtrl.showLoader()
        Aura.media.resizeAndUpload(id, file)

      'dragover [data-image]': (e)->
        if e.preventDefault then e.preventDefault()
        $(e.target).closest('[data-image]').addClass('_hover')
        return false
      'dragenter [data-image]': (e)->
        if e.preventDefault then e.preventDefault()
        $(e.target).closest('[data-image]').addClass('_hover')
        return false
      'dragleave [data-image]': (e)->
        $(e.target).closest('[data-image]').removeClass('_hover')
        return false
      'drop [data-image]': (e)->
        e.preventDefault()
        e.stopPropagation()
        $(e.target).removeClass('_hover')
        file = e.originalEvent.dataTransfer.files[0]
        fr = new FileReader()
        MainCtrl.showLoader()
        fr.onload = ->
          pic = {}
          pic['data'] = fr.result
          pic['name'] = file.name
          pic['size'] = file.size
          pic['type'] = file.type
          currentPic = do ->
            if $(e.target).closest('[data-image]').data('image-target') is 'background'
              path = $(e.target).closest('[data-image]').css('background-image')
              _.last(path.split('/')).replace(')', '')
            else
              path = $(e.target).closest('[data-image]').attr('src')
              _.last path.split('/')
          target = $(e.target).closest('[data-image]').data('image-target') or 'img'
          (new PNotify({
            title: 'Удалить старое изображение?',
            text: 'Желательно удалять, чтобы не перегружать хостинг',
            hide: false,
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

            Aura.media.updatePic(e, pic, file, target, currentPic, false)

          ).on('pnotify.cancel', ->
            Aura.media.uploadPic(e, pic, file, target, false)
          )

        fr.readAsBinaryString(file)

      'click .aura-toggle-edit': (e)->
        $(e.currentTarget).toggleClass('_active')
        if $(e.currentTarget).hasClass('_active')
          Session.set 'admin.editMode', true
          $(e.currentTarget).find('p').text('правка')
        else
          Session.set 'admin.editMode', false
          $(e.currentTarget).find('p').text('просмотр')

    }






@Aura = {

  showAdminModal: ->
    $('#admin-login-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

  hideAdminModal: ->
    $('#admin-login-modal').removeClass('flipInY').addClass('flipOutY')
    setTimeout ->
      $('#admin-login-modal').css('visibility', 'hidden')
    , 500

  notify: (message)->
    new PNotify({
      title: 'Спасибо!',
      text: message,
      addclass: 'aura-notify'
    })



  saveContent: (name, query, newContent, prevContent)->

    #This method saves content and passes data to the saveHistory and log method

    Meteor.call 'saveContent', name, query, newContent, (err, res)->
      #

  inputInstantTimeout: null



  media: {

    uploadPic: (e, pic, file, callback)->

      NProgress.start()

      Meteor.call 'uploadPic', pic, 'ahsl2/images', (err, res)->
        NProgress.done()

        if err
#          MainCtrl.hideLoader()
          Aura.notify('Произошла ошибка, обратитесь к разработчику!')
        else
          if $(e.currentTarget).data('aura-image-background') or $(e.currentTarget).data('aura-image')
            query = do ->
              $(e.currentTarget).data('aura-image-background') or $(e.currentTarget).data('aura-image')
            item = {}
            item['document'] = query.split('.')[0]
            item['field'] = query.split('.').splice(1).join()
            item['data'] = res
          else if $(e.currentTarget).data('aura-list-image-background') or $(e.currentTarget).data('aura-list-image')
            query = $(e.currentTarget).data('aura-list-image-background') or $(e.currentTarget).data('aura-list-image')
            list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list')
            index = $(e.currentTarget).closest('[data-aura-list-item]').index()
            item = {}
            item['document'] = list.split('.')[0]
            item['field'] = list.split('.')[1] + '.' + index + '.' + query
            item['data'] = res
          else if $(e.currentTarget).data('aura-with-image-background') or $(e.currentTarget).data('aura-with-image')
            query = $(e.currentTarget).data('aura-with-image-background') or $(e.currentTarget).data('aura-with-image')
            withRule = $(e.currentTarget).closest('[data-aura-with]').data('aura-with')
            withQuery = do ->
              if withRule.split('.')
                withRule.split('.')[0]
              else
                withRule
            item = {}
            item['document'] = withQuery
            item['field'] = query
            item['data'] = res

          item['collection'] = do ->
            if $(e.currentTarget).parents('[data-aura-collection]').length > 0
              $(e.currentTarget).parents('[data-aura-collection]').data('aura-collection')
            else
              'auraPages'

          item['index'] = do ->
            if $(e.currentTarget).parents('[data-aura-index]').length > 0
              $(e.currentTarget).parents('[data-aura-index]').data('aura-index')
            else
              'name'

          Meteor.call 'saveHtml', item, (error, response)->
            if err then console.log 'Smth went wrong'
          console.log item


    updatePic: (e, pic, file, currentPic)->

      Meteor.call 'deletePic', currentPic, 'ahsl2/images', (err, res)->

        if err

          Aura.notify 'Изображение не удалено:( Может и к лучшему))'

        else

          if res

            Aura.media.uploadPic(e, pic, file)

          else

            Aura.notify 'Изображение не удалено:( Ошибка на стороне сервера'

    resizeAndUpload: (id, file)->

      console.log 'triggered upload with resize'

      pic = {}
      resizedPic = {}

      deferred = $.Deferred()

      resize = ()->
        reader = new FileReader()
        reader.readAsDataURL(file)
        reader.onLoad = (e)->
          $.canvasResize(file, {
            width: 300,
            height: 0,
            crop: false,
            quality: 80,
            callback: (data)->
              deferred.resolve(data)
              console.log {data: data}
          })
        deferred.promise()


      originalFile = ()->
        reader = new FileReader()
        deferred = $.Deferred()
        reader.readAsBinaryString(file)
        reader.onload = (e)->
          ifile = reader.result
          deferred.resolve(ifile)
          console.log {reader: ifile}
        deferred.promise()



      $.when(originalFile(), resize()).done (ifile, resizedFile)=>
        console.log 'resolved'
        pic['fileInfo'] = file
        pic['data'] = ifile
        resizedPic['fileInfo'] = file
        resizedPic['data'] = resizedFile
        console.log pic
        console.log resizedPic
        Meteor.call 'uploadWithThumb', [pic, resizedPic], (err, res)->
          if err

            Aura.notify 'Упс, что-то пошло не так:('

          else

            if res

              console.log res

              Gallery.update id, {$push: {'images': res}}, ->

                Aura.notify 'Изображение ' + res + ' добавлено!'

                MainCtrl.hideLoader()

            else

              Aura.notify 'Что-то пошло не так, обратитесь к разработчику!'

    deletePic: (pic)->

      Meteor.call 'deletePic', pic, (err, res)->

        if err

          Aura.notify 'Изображение не удалено:( Может и к лучшему))'

        else

          if res

            Aura.notify 'Изображение успешно удалено!'

          else

            Aura.notify 'Изображение не удалено:( Ошибка на стороне сервера'

    deletePics: (pics)->

      Meteor.call 'deletePics', pics, (err, res)->

        if err

          Aura.notify 'Изображения не удалены:( Может и к лучшему))'

        else

          if res

            Aura.notify 'Изображения успешно удалено!'

          else

            Aura.notify 'Изображения не удалены:( Ошибка на стороне сервера'

  }


  _logsWrite: (buffer)->

    _.each buffer, (log)->
      Logs.insert {
        field: log.field,
        collection: log.collection,
        date: new Date()
        user: 'Albert Kai'
      }

  _historyBuffer: []

  _saveHistory: (buffer)->

    console.log 'triggered saveHistory'

    historyCount = History.find().count()
    if historyCount + buffer.length > Aura.settings.history.size
      toDeleteSize = historyCount + buffer.length - Aura.settings.history.size
      toDelete = History.find({}, {sort: {date : 1}, limit: toDeleteSize }).fetch()
      toDelete.forEach (item)->
        id = item._id
        History.remove id


    _.each buffer, (history)->
      if !history.rolledBack
        History.insert({
          field: history.field,
          collection: history.collection,
          document: history.document
          indexField: history.indexField
          date: new Date()
          data: history.data
          selectorPath: history.selectorPath
          newData: history.newData
          type: history.type
          user: Meteor.user()
          rolledBack: history.rolledBack
          changable: history.changeable
        })
        console.log 'triggered saveHistory iterate'

      else
        target = History.findOne({_id: history._id})
        target.rolledBack = !buffer.rolledBack
        History.update {_id: history._id}, history


    Aura._historyBuffer = []

  _historyRestore: (id)->

    historyItem = History.findOne({_id: id})

    if historyItem.rolledBack

      restoredBuffer = []

      restoredBuffer.push {
        field: historyItem.field
        document: historyItem.document
        collection: historyItem.collection
        indexField: historyItem.indexField
        data: historyItem.newData
        nested: historyItem.nested
      }
      console.log restoredBuffer
      editor.editorSaveText restoredBuffer, ->
        History.update {_id: id}, {$set: {rolledBack: false}}
        console.log 'history restored'

    else

      changedBuffer = []

      changedBuffer.push {
        field: historyItem.field
        document: historyItem.document
        collection: historyItem.collection
        indexField: historyItem.indexField
        data: historyItem.data
        nested: historyItem.nested
      }
      console.log changedBuffer
      editor.editorSaveText changedBuffer, ->
        History.update {_id: id}, {$set: {rolledBack: true}}
        console.log 'history restored'













  users: {

    addUser: (object)->

      Meteor.call 'auraAddUser', (options)->




  }

}


@editor = {

  blured: false

  _editingItem: ''

  _changedBuffer: []

  commands: {

    bold: ()->

      document.execCommand('bold', null, null)

    italic: ->

      document.execCommand('italic', null, null)

    sub: ->

      document.execCommand('subscript', null, null)

    sup: ->

      document.execCommand('superscript', null, null)

    ul: ->

      document.execCommand('insertUnorderedList', null, null)

    ol: ->

      document.execCommand('insertOrderedList', null, null)

    h1: ->

      document.execCommand('formatBlock', null, '<h1>')

    h2: ->

      document.execCommand('formatBlock', null, '<h2>')

    h3: ->

      document.execCommand('formatBlock', null, '<h3>')


    h4: ->

      document.execCommand('formatBlock', null, '<h4>')


    h5: ->

      document.execCommand('formatBlock', null, '<h5>')


    h6: ->

      document.execCommand('formatBlock', null, '<h6>')


    span: ->

      document.execCommand('formatBlock', null, '<span>')

    link: ->

      document.execCommand('createLink', false, prompt('Введите URL'))
  }



  save: ->

    if @_changedBuffer.length > 0
      length = @_changedBuffer.length
      counter = 0
      for num in [0...length]
        console.log num
        Meteor.call 'saveHtml', @_changedBuffer[num], (err, res)->
          if err then console.log err else console.log 'changed item saved'
        Meteor.call 'saveHistory', Aura._historyBuffer[num], (err, res)->
          if err then console.log err else console.log 'history item saved'
        counter++
        if counter is length
          @_changedBuffer = []
          Aura._historyBuffer = []
          Aura.notify 'Изменения сохранены!'


  imageEmbedEdit: '<div class="image-embed-edit"><button id="set-float-left" data-class="aura-float-left"><i class="fa fa-long-arrow-left"></i></button><button id="set-centered" data-class="aura-centered"><i class="fa fa-arrows-h"></i></button><button id="set-float-right" data-class="aura-float-right"><i class="fa fa-long-arrow-right"></i></button><button class="remove"><i class="fa fa-times"></i></button></div>'


  _trackChanges:

    currentValue: ''

    check: ($el)->

      console.log @currentValue

      if $el.html() isnt @currentValue

        true

      else

        false


  _saveText: (buffer)->

    editor.editorSaveText buffer, ->


      Aura._logsWrite(Aura._historyBuffer)

      Aura._saveHistory(Aura._historyBuffer)

      editor._changedBuffer = []

      console.log 'changed'

      Aura.notify('Изменения сохранены!')

    true

  editorSaveText: (changedBuffer, callback)->

    console.log changedBuffer

    user = Meteor.user()

    if Roles.userIsInRole user, ['admin']

      console.log 'triggered saveText'

      _.each changedBuffer, (change)->

        if !change.nested

          console.log 'triggered saveText iterate'

          newData = {}

          query = {}
          query[change.indexField] = change.document

          pageId = eColl[change.collection].findOne(query)._id

          newData[change.field] = change.data

          eColl[change.collection].update pageId, {$set: newData}, ->
            console.log 'saved'

            console.log change.data

          callback()


        else if change.nested.type is 'array'

          console.log 'triggered saveText iterate array'

          newData = {}

          query = {}
          query[change.indexField] = change.document

          updateObj = {}

          updateObj['_id'] = eColl[change.collection].findOne(query)._id

          console.log eColl[change.collection].findOne({'name': change.document})._id

          updateObj[change.nested.field + '.id'] = change.nested.id

          newData[change.nested.field + '.$.' + change.field] = change.data

          eColl[change.collection].update updateObj, {$set: newData}, ->
            console.log 'saved'

          callback()

    else

      Meteor.Error(403, 'Not allowed')


  showEditor: (val)->

    $('.editor').addClass('_opened')
    $('.editor').find('button').removeClass('_active')
#    editor.auraEditorHtml.setValue(val)

  hideEditor: ->
    $('.editor').removeClass('_opened')
    $('.editor').find('.html-cont').removeClass('flipInX').addClass('flipOutX')

}


Aura.settings = {
  history: {
    size: 50
  }
}

