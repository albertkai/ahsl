
if Meteor.isClient

  console.log 'aura is working'

  Session.setDefault 'admin.editMode', false

  AuraColl['users'] = Meteor.users

  Meteor.subscribe 'users'
  Meteor.subscribe 'auraPages'
#  Meteor.subscribe 'auraHistory'

  #Regestering helpers

  Template.registerHelper 'common', ->
    AuraPages.findOne({name: 'common'})

  Template.registerHelper 'index', ->
    AuraPages.findOne({name: 'index'})

  Template.registerHelper 'userIsAdmin', ->
    Roles.userIsInRole(Meteor.userId(), ['owner','admin'])

  Template.registerHelper 'contacts', ->
    AuraPages.findOne({name: 'contacts'})

  Template.registerHelper 'summer', ->
    AuraPages.findOne({name: 'summer'})

  Template.registerHelper 'children', ->
    AuraPages.findOne({name: 'children'})

  Template.registerHelper 'teens', ->
    AuraPages.findOne({name: 'teens'})

  Template.registerHelper 'lateTeens', ->
    AuraPages.findOne({name: 'lateTeens'})

  Template.registerHelper 'grownUps', ->
    AuraPages.findOne({name: 'grownUps'})

  Template.registerHelper 'international', ->
    AuraPages.findOne({name: 'international'})

  Template.registerHelper 'summerSchool', ->
    AuraPages.findOne({name: 'summerSchool'})

  Template.registerHelper 'eventsList', ->
    AuraPages.findOne({name: 'events'})

  Template.registerHelper 'inputInstantGetDate', (date)->
    moment(date).lang('ru').format('YYYY-MM-DD')

  Template.registerHelper 'getDate', (date)->
    moment(date).lang('ru').format('DD.MM.YYYY, hh:mm')

  Template.registerHelper 'history', ->
    AuraHistory.find({}, {sort: {date: -1}})

  Template.registerHelper 'newRequests', ->
    Session.get('newRequests')

  Template.registerHelper 'email', ->
    AuraPages.findOne({name: 'email'})

  Template.registerHelper 'auraCheckboxIsChecked', (value)->
    if value
      'checked'
    else
      ''

  Template.registerHelper 'storagePath', ->
    'http://d1tvqt3gjtui5j.cloudfront.net'

  Meteor.startup ->

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

    Mousetrap.bind ['ctrl+shift+e', 'command+shift+e', 'ctrl+shift+у', 'ctrl+shift+у'], (e)->
      Aura.toggleEditMode()

    Mousetrap.bind ['ctrl+shift+s', 'command+shift+s', 'ctrl+shift+ы', 'ctrl+shift+ы'], (e)->
      $(editor.editingItemSelector).trigger('blur')
      $('.editor').find('#b-save').trigger('click')


    Template.auraAdminPanel.events {

#      'click #edit-mode': (e)->
#        if $(e.target).is(':checked')
#          Session.set('admin.editMode', true)
#          aloha.dom.query('[data-aura-html]', document).forEach(aloha)
#        else
#          Session.set('admin.editMode', false)
#          aloha.dom.query('[data-aura-html]', document).forEach(aloha.mahalo)

      'mouseleave #history-cont li': (e)->
        if Aura.historyDiffTimeout
          Meteor.clearTimeout(Aura.historyDiffTimeout)
        $('.aura-diff-cont').remove()

      'mouseenter #history-cont li': (e)->
        if Aura.historyDiffTimeout
          Meteor.clearTimeout(Aura.historyDiffTimeout)
        Aura['historyDiffTimeout'] = Meteor.setTimeout ->

          Aura['diff'] = new diff_match_patch()
          item = AuraHistory.findOne({_id: $(e.currentTarget).data('id')})
          selectorPath = item.collection + '::' + item.document + '::' + item.field
          changedData = item.changedData
          data = item.data
          diff = Aura.diff.diff_prettyHtml(Aura.diff.diff_main(changedData, data))
          markup = Blaze.toHTMLWithData Template.historyDiffCont, {selectorPath: selectorPath}
          $('body').append(markup)
          $('.aura-diff-cont').css('top', ($(e.currentTarget).offset().top - $(window).scrollTop()) + 'px').css('left', $(e.currentTarget).offset().left + 'px').addClass '_visible'
          $('.aura-diff-cont').find('p').html($.htmlClean(diff, {format:true}))
        , 1000

      'click #history-cont li': (e)->
        selectorPath = $(e.currentTarget).data('selector-path')
        id = $(e.currentTarget).data('id')
        Meteor.call 'restoreHistory', id, (err, res)->
          if err
            console.log err
          else
            Aura.notify 'История восстановлена!'
            if $(selectorPath).length > 0
              Meteor.defer ->
                $(selectorPath).html(res)
            console.log 'changed item saved'

      'click #toggle-users': ->

        $('#auraUsersModal').addClass '_opened'

      'click #toggle-requests': ->

        $('#aura-requests-modal').addClass '_opened'

      'click #toggle-mailing': ->

        $('#emailModal').modal('show')

        if $('#mailing-bases-cont').html() is ''

          Meteor.call 'getBasesList', (err, res)->

            if err
              console.log err
            else
              markup = ''
              res.forEach (b)->
                markup += '<div><input type="checkbox" value="' + b.id + '"/><p>' + b.name + ' <span>' + b.active + '</span></p></div>'
              $('#mailing-bases-cont').html(markup)

      'click .aura-toggle-edit': (e)->
        $(e.currentTarget).toggleClass('_active')
        if $(e.currentTarget).hasClass('_active')
          Session.set 'admin.editMode', true
          $(e.currentTarget).find('p').text('правка')
        else
          Session.set 'admin.editMode', false
          $(e.currentTarget).find('p').text('просмотр')

#      'click #history-cont li': (e)->
#        target = $(e.target).closest('li').data('id')
#        Aura._historyRestore(target)

      'click .aura-admin-button': (e)->

        if $(e.currentTarget).attr('data-admin-toggle')

          if $(e.currentTarget).hasClass '_expanded'
            $(e.currentTarget).removeClass '_expanded'
            target = $(e.currentTarget).data('admin-toggle')
            $(target).removeClass('_expanded').height(0)
          else
            $(e.currentTarget).addClass '_expanded'
            target = $(e.currentTarget).data('admin-toggle')
            $(target).addClass('_expanded').height($(target).find('>ul').height())
    }

    Template.aura.rendered = ->

#      $.getScript '/scripts/ace.js', ->
#        console.log 'ace loaded'
#        editor.htmlEditorInit()


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

        $(e.currentTarget).addClass('_active').siblings().removeClass('_active')

        if $(e.currentTarget).hasClass('add-user')

          Session.set('auraSelectedUser', 'new')

        else

          id = $(e.currentTarget).data('id')
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
            pic: null
          }

          if Meteor.users.findOne('emails.$.address': options.email)

            Aura.notify 'Пользователь с таким e-mail уже существует!'

          else

            if $('#user-pic').get(0).files[0]

              NProgress.start()
              file = $('#user-pic').get(0).files[0]
              fr = new FileReader()
              fr.onload = ->
                pic = {}
                pic['data'] = fr.result
                pic['name'] = file.name
                pic['size'] = file.size
                pic['type'] = file.type
                Meteor.call 'uploadPic', pic, 'ahsl2/aura', (error, newPic)->
                  NProgress.done()
                  if error
                    console.log error
                  else
                    options['pic'] = newPic
                    Meteor.call 'auraCreateUser', options, (err, res)->

                      if err
                        Aura.notify 'Упс, что-то не так на сервере:( Обратитесь к разработчику', 'error'

                      else

                        Aura.notify 'Ура, пользователь создан!', 'success'
                        console.log res

              fr.readAsBinaryString(file)

            else

              Meteor.call 'auraCreateUser', options, (err, res)->

                if err
                  Aura.notify 'Упс, что-то не так на сервере:( Обратитесь к разработчику', 'error'

                else

                  Aura.notify 'Ура, пользователь создан!', 'success'
                  console.log res

        else

          Aura.notify 'Пожалуйста, корректно заполните все поля формы, отмеченные звездочкой!'


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


      $('.html-cont').on 'keyup', ->
        Meteor.setTimeout ->
          console.log 'changing value'
          value = editor.auraEditorHtml.getValue().replace(/\s+/g, ' ')
          target = $('.editor').find('.html-cont').data('path')
          console.log target
          console.log value
          $(target).html(value)
        , 50

    Template.auraEditor.events {

      'click button': (e)->
        console.log editor.editingItemSelector
        if editor.editingItemSelector
          data = editor.editingItemSelector.html()
          editor.editingItemSelector.trigger('input')
          Meteor.setTimeout ->
            editor.editingItem = data
          , 100

      'click #b-html': (e)->
        console.log 'opening editor'
        if $(e.target).hasClass('_active')
          $('.editor .html-cont').removeClass('flipInX').addClass('flipOutX')
          $(e.currentTarget).removeClass('_active')
        else
          $('.editor .html-cont').css('visibility', 'visible').removeClass('flipOutX').addClass('animated flipInX')
          $(e.currentTarget).addClass('_active')

#      'click .editor .html-cont button': (e)->
#        path = $('.editor .html-cont').data('path')
#        val = $('.editor .html-cont').data('resetData')
#        editor.auraEditorHtml.setValue(val)
#        $(path).html(val)
#
#      'input .editor .html-cont textarea': (e)->
#        path = $(e.target).data('path')
#        $(path).html($(e.target).val().trim())

      'blur .editor .html-cont textarea': (e)->
#        console.log 'html editor blured'
#        index = $(e.target).data('index')
#        html = $(e.target).val()
#        console.log index
#        console.log $(e.target).data('path')
#        editor._changedBuffer[index].data = html
        $($(e.target).data('path')).trigger('blur')

      'change #add-embed-image': (e)->

        console.log 'uploading embed image'
        input = $(e.target)
        file = input.get(0).files[0]
        fr = new FileReader()
        NProgress.start()
        fr.onload = ->
          pic = {}
          pic['data'] = fr.result
          pic['name'] = file.name
          pic['size'] = file.size
          pic['type'] = file.type
          Meteor.call 'uploadPic', pic, 'ahsl2/images', (error, newPic)->
            NProgress.done()
            if error
              console.log error
            else
              path = 'http://d1tvqt3gjtui5j.cloudfront.net/images/' + newPic
              html = document.createElement('img')
              html.setAttribute('src', path)
              html.setAttribute('data-aura-image-embed', '')
              html.setAttribute('class', 'aura-float-left')
              editor.commands.pasteHtml(html)
              $(e.currentTarget).closest('[contenteditable]').trigger('input')

        fr.readAsBinaryString(file)




      'click #b-bold': ->
        editor.commands.bold()

      'click #b-add-quot': ->
        el = document.createElement('p')
        el.setAttribute('class', 'inline-quot')
        editor.commands.wrapRange(el)

      'click #b-add-video': ->
        code = prompt("Пожалуйста добавьте код видео с YouTube")
        editor.commands.pasteHtml(code)

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

      'click #b-align-left': ->
        editor.commands.justifyLeft()

      'click #b-align-right': ->
        editor.commands.justifyRight()

      'click #b-align-center': ->
        editor.commands.justifyCenter()

      'click #b-align-justify': ->
        editor.commands.justifyFull()

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

    $('body').on 'paste', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"]', (e)->
      console.log 'pasted'
      $el = $(e.target).closest('[contenteditable="true"]')
      Meteor.defer ->
        html = $el.html()
        cleanHtml = AuraUtils.cleanHTML(html)
        console.log cleanHtml
        $el.html(cleanHtml)
      , 100

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
      editor.editingItemSelector = $(e.currentTarget)
#      editor.auraEditorHtml.setValue(markup)
      $('.editor .html-cont').data('resetData', markup)
      $('.editor .html-cont').data('path', $(e.target).closest('[contenteditable="true"]').getPath())


    $('body').on 'blur', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"],  [data-aura-with-html][contenteditable="true"]', (e)->

      console.log 'blurred'
      if !editor.blured
        console.log 'editor not blured'
        currentState = $(e.currentTarget).html()
        if currentState isnt editor.editingItem

          console.log('currentState isnt editor.editingItem')

          $('.editor .html-cont textarea').data('index', editor._changedBuffer.length)

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
            if $(e.currentTarget).closest('[data-aura-collection]').length > 0
              $(e.currentTarget).closest('[data-aura-collection]').data('aura-collection')
            else
              'auraPages'

          docIndex = do ->
            if $(e.currentTarget).closest('[data-aura-index]').length > 0
              $(e.currentTarget).closest('[data-aura-index]').data('aura-index')
            else
              'name'

          console.log 'indx'
          console.log docIndex
          console.log coll

          editor._changedBuffer.push {
            field: field
            document: document
            index: docIndex
            collection: coll
            data: $.htmlClean(currentState, {format: true})
            changedData: $.htmlClean(editor.editingItem, {format: true})
            selectorPath: $(e.currentTarget).getPath()
            type: 'html'
          }
          console.log editor._changedBuffer
          $(e.target).closest('[contenteditable="true"]').addClass('_changed')
          editor.blured = true
          Meteor.setTimeout ->
            editor.blured = false
          , 1000


    $('body').on 'input', '[data-aura-html][contenteditable=true], [data-aura-with-html][contenteditable=true], [data-aura-list-html][contenteditable=true]', (e)->
      markup = $(e.currentTarget).html()
#      editor.auraEditorHtml.setValue($.htmlClean(markup, {format:true}))


    #Editor add image


    $('body').on 'click', '[data-aura-list-remove]', (e)->
      index = $(e.currentTarget).closest('[data-aura-list-item]').index()
      list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list')
      document = list.split('.')[0]
      field = list.split('.')[1]
      object = AuraPages.findOne({name: document}).classes[index]
      Meteor.call 'removeListItem', document, field, object, (err, res)->
        if err then console.log err

    $('body').on 'click', '[data-aura-list-add]', (e)->
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
        $(editor.editingItemSelector).trigger('blur')
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


    $('body').on 'change', '[data-aura-instant-checkbox]', (e)->

      query = $(e.currentTarget).data('aura-instant-checkbox').split('.')
      value = $(e.currentTarget).val()
      item = {}
      item['collection'] = query[0]
      item['document'] = query[1]
      item['index'] = '_id'
      query.shift()
      query.shift()
      item['field'] = query
      item['data'] = $(e.currentTarget).is(':checked')
      Meteor.call 'saveHtml', item, (err, res)->
        if err
          console.log err
        else
          Aura.notify 'Изменения сохранены!'


    $('body').on 'change', '[data-aura-instant-select]', (e)->

      if $(e.currentTarget).val() isnt '-'

        query = $(e.currentTarget).data('aura-instant-select').split('.')
        value = $(e.currentTarget).val()
        item = {}
        item['collection'] = query[0]
        item['document'] = query[1]
        item['index'] = '_id'
        query.shift()
        query.shift()
        item['field'] = query
        item['data'] = value
        Meteor.call 'saveHtml', item, (err, res)->
          if err
            console.log err
          else
            Aura.notify 'Изменения сохранены!'



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
          else
            value
        console.log item
        Meteor.call 'saveHtml', item, (err, res)->
          if err
            console.log err
          else
            Aura.notify 'Изменения сохранены!'
            if $(e.currentTarget).attr('id') is 'aura-alias-input'
              Router.go Router.current().route.getName(), {alias: value}
      , 1500


#    Template.body.events {
#
#      'focus [data-aura-html][contenteditable="true"]': (e)->
#        console.log 'focused'
#        data = $(e.currentTarget).html()
#        markup = $.htmlClean(data, {format:true})
#        editor.showEditor(markup)
#        editor._trackChanges.currentValue = data
#        editor.editingItem = data
#        $('.editor .html-cont').data('resetData', markup)
#        $('.editor .html-cont').data('path', $(e.target).closest('[contenteditable="true"]').getPath())
#
#      'input [contenteditable="true"]': (e)->
#        markup = $(e.target).html()
#        editor.auraEditorHtml.setValue($.htmlClean(markup, {format:true}))
#
#      'click #admin-login-modal .close': ->
#        Aura.hideAdminModal()
#
#      'submit #aura-login-form': (e)->
#        e.preventDefault()
#        console.log 'logging in'
#        email = $('#aura-login-form').find('#login-email').val()
#        password = $('#aura-login-form').find('#login-password').val()
#        Meteor.loginWithPassword email, password, (err)->
#          if err
#            Aura.notify 'Ошибочка:('
#          else
#            Aura.notify 'Добро пожаловать!'
#            Aura.hideAdminModal()
#        false
#
#      'blur [data-aura-html][contenteditable="true"]': (e)->
#        console.log 'blurred'
#        if !editor.blured
#          currentState = $(e.currentTarget).html()
#          if currentState isnt editor.editingItem
#            query = $(e.target).data('aura-html')
#            $('.editor .html-cont textarea').data('index', Aura._historyBuffer.length)
#            document = query.split('.')[0]
#            field = query.split('.').shift().join()
#
#            Aura._historyBuffer.push {
#              field: field
#              document: document
#              prevData: editor.editingItem
#              newData: currentState
#              selectorPath: $(e.currentTarget).getPath()
#              type: 'html'
#            }
#            editor._changedBuffer.push {
#              field: field
#              document: document
#              data: currentState
#            }
#            console.log editor._changedBuffer
#            console.log Aura._historyBuffer
#            $(e.target).closest('[contenteditable="true"]').addClass('_changed')
#            editor.blured = true
#            Meteor.setTimeout ->
#              editor.blured = false
#            , 1000
#
#      'change .aura-edit-image input[type="file"]': (e)->
#        input = $(e.target)
#        file = input.get(0).files[0]
#        fr = new FileReader()
#        MainCtrl.showLoader()
#        fr.onload = ->
#          pic = {}
#          pic['data'] = fr.result
#          pic['name'] = file.name
#          pic['size'] = file.size
#          pic['type'] = file.type
#          currentPic = do ->
#            if $(e.target).closest('[data-image]').data('image-target') is 'background'
#              path = $(e.target).closest('[data-image]').css('background-image')
#              _.last(path.split('/')).replace(')', '')
#            else
#              path = $(e.target).closest('[data-image]').attr('src')
#              _.last path.split('/')
#          target = $(e.target).closest('[data-image]').data('image-target') or 'img'
#          (new PNotify({
#            title: 'Удалить старое изображение?',
#            text: 'Желательно удалять, чтобы не перегружать хостинг',
#            hide: false,
#            addclass: 'aura-notify',
#            confirm: {
#              confirm: true
#            },
#            buttons: {
#              closer: false,
#              sticker: false
#            },
#            history: {
#              history: false
#            }
#          })).get().on('pnotify.confirm', ->
#
#            Aura.media.updatePic(e, pic, file, target, currentPic)
#
#          ).on('pnotify.cancel', ->
#            Aura.media.uploadPic(e, pic, file, target)
#          )
#
#        fr.readAsBinaryString(file)
#
#      'change .auraModal .list-cont .add input[type="file"]': (e)->
#        console.log 'triggered change'
#        input = $(e.target)
#        file = input.get(0).files[0]
#        id = $('#albumId').val()
#        fr = new FileReader()
#        MainCtrl.showLoader()
#        Aura.media.resizeAndUpload(id, file)
#
#      'dragover [data-image]': (e)->
#        if e.preventDefault then e.preventDefault()
#        $(e.target).closest('[data-image]').addClass('_hover')
#        return false
#      'dragenter [data-image]': (e)->
#        if e.preventDefault then e.preventDefault()
#        $(e.target).closest('[data-image]').addClass('_hover')
#        return false
#      'dragleave [data-image]': (e)->
#        $(e.target).closest('[data-image]').removeClass('_hover')
#        return false
#      'drop [data-image]': (e)->
#        e.preventDefault()
#        e.stopPropagation()
#        $(e.target).removeClass('_hover')
#        file = e.originalEvent.dataTransfer.files[0]
#        fr = new FileReader()
#        MainCtrl.showLoader()
#        fr.onload = ->
#          pic = {}
#          pic['data'] = fr.result
#          pic['name'] = file.name
#          pic['size'] = file.size
#          pic['type'] = file.type
#          currentPic = do ->
#            if $(e.target).closest('[data-image]').data('image-target') is 'background'
#              path = $(e.target).closest('[data-image]').css('background-image')
#              _.last(path.split('/')).replace(')', '')
#            else
#              path = $(e.target).closest('[data-image]').attr('src')
#              _.last path.split('/')
#          target = $(e.target).closest('[data-image]').data('image-target') or 'img'
#          (new PNotify({
#            title: 'Удалить старое изображение?',
#            text: 'Желательно удалять, чтобы не перегружать хостинг',
#            hide: false,
#            confirm: {
#              confirm: true
#            },
#            buttons: {
#              closer: false,
#              sticker: false
#            },
#            history: {
#              history: false
#            }
#          })).get().on('pnotify.confirm', ->
#
#            Aura.media.updatePic(e, pic, file, target, currentPic, false)
#
#          ).on('pnotify.cancel', ->
#            Aura.media.uploadPic(e, pic, file, target, false)
#          )
#
#        fr.readAsBinaryString(file)
#

#
#    }






@Aura = {

  showAdminModal: ->
    $('#admin-login-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

  hideAdminModal: ->
    $('#admin-login-modal').removeClass('flipInY').addClass('flipOutY')
    setTimeout ->
      $('#admin-login-modal').css('visibility', 'hidden')
    , 500

  toggleEditMode: ->

    if Session.get('admin.editMode')
      Session.set('admin.editMode', false)
      Aura.notify 'Режим просмотра'
    else
      Session.set('admin.editMode', true)
      Aura.notify 'Режим правки'

  notify: (message)->
    new PNotify({
      title: 'Спасибо!',
      text: message,
      addclass: 'aura-notify'
    })

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
            if $(e.currentTarget).closest('[data-aura-collection]').length > 0
              $(e.currentTarget).closest('[data-aura-collection]').data('aura-collection')
            else
              'auraPages'

          item['index'] = do ->
            if $(e.currentTarget).closest('[data-aura-index]').length > 0
              $(e.currentTarget).closest('[data-aura-index]').data('aura-index')
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

    resizeAndUpload: (id, file, callback)->

      console.log 'triggered upload with resize'

      fileInfo = file

      resize = ()->
        console.log 'procesing resize '

        deferred = $.Deferred()

        $.canvasResize(file, {
          width: 150,
          height: 0,
          crop: false,
          quality: 80,
          callback: (data)->
            deferred.resolve(data)
            console.log 'resized img'
            console.log {data: data}
        })

        deferred.promise()

      originalFile = ()->

        deferred2 = $.Deferred()

        console.log 'processing original file'

        reader = new FileReader()

        reader.readAsBinaryString(file)
        reader.onload = (e)->
          ifile = reader.result
          deferred2.resolve(ifile)
          console.log {reader: ifile}
        deferred2.promise()



      $.when(originalFile(), resize()).done (ifile, resizedFile)=>

        pic = {}
        resizedPic = {}
        pic['fileInfo'] = {}
        resizedPic['fileInfo'] = {}

        console.log 'resolved'

        #Explicitly cloning needed properties from the file object, avoiding weirt Firefox behavior

        pic['fileInfo']['name'] = fileInfo.name
        pic['fileInfo']['type'] = fileInfo.type
        pic['fileInfo']['size'] = fileInfo.size
        pic['data'] = ifile

        resizedPic['fileInfo']['name'] = fileInfo.name
        resizedPic['fileInfo']['type'] = fileInfo.type
        resizedPic['fileInfo']['size'] = fileInfo.size
        resizedPic['data'] = resizedFile

        Meteor.call 'uploadWithThumb', [pic, resizedPic], 'ahsl2/gallery', (err, res)->
          if err

            Aura.notify 'Упс, что-то пошло не так:('

          else

            if res

              callback(res)

            else

              Aura.notify 'Что-то пошло не так, обратитесь к разработчику!'

    deletePic: (pic)->

      Meteor.call 'deletePic', pic, 'ahsl2/images', (err, res)->

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






  users: {

    addUser: (options)->

      Meteor.call 'auraAddUser', (options)->




  }

}


@editor = {

  blured: false

  editingItem: ''

  _changedBuffer: []

  editingItemSelector: null

  auraEditorHtml: null

  htmlEditorInit: ->

    editor.auraEditorHtml = ace.edit("editorHtml")
#    editor.auraEditorHtml.setTheme("ace/theme/monokai")
#    editor.auraEditorHtml
#    editor.auraEditorHtml.on 'change', (e)->
#      value = editor.auraEditorHtml.getValue().replace(/\s+/g, ' ')
#      target = $('.editor').find('.html-cont').data('path')
#      console.log target
#      console.log value
#      $(target).html(value)

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

    justifyLeft: ->

      document.execCommand('justifyLeft', null, null)

    justifyCenter: ->

      document.execCommand('justifyCenter', null, null)

    justifyRight: ->

      document.execCommand('justifyRight', null, null)

    justifyFull: ->

      document.execCommand('justifyFull', null, null)


    pasteHtml: (html)->

      range = window.getSelection().getRangeAt(0)
      range.insertNode html

    wrapRange: (node)->

      sel = window.getSelection()
      if sel.rangeCount
        range = sel.getRangeAt(0).cloneRange()
        range.surroundContents(node)
        sel.removeAllRanges()
        sel.addRange(range)

  }



  save: ->

    console.log 'saving content'

    if @_changedBuffer.length > 0
      changedBuffer = editor._changedBuffer
      length = changedBuffer.length
      counter = 0
      changedBuffer.forEach (buffer)->
        Meteor.call 'saveHtml', buffer, (err, res)->
          if err
            console.log err
          else
            console.log buffer
            console.log buffer.selectorPath
            Meteor.defer ->
              $(buffer.selectorPath).html(buffer.data)
              console.log 'refreshed'
            console.log 'changed item saved'

        counter++
        if counter is length
          editor._changedBuffer = []
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
    size: 30
  }
}

