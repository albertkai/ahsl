Template.eventCreateModal.rendered = ->

  Meteor.defer ->
    @.$('#blog-create-modal').addClass '_opened'

Template.eventCreateModal.events {

  'click .remove': (e)->
    $(e.currentTarget).closest('#event-create-modal').removeClass '_opened'

  'click button': (e)->
    alias = $('#event-alias').val()
    title = $('#event-title').val()
    date = Date.parse(new Date($('#event-date').val()))
    if alias isnt '' and title isnt ''
      if !Events.findOne({alias: alias})
        if !alias.split(' ')[1]
          $('#event-create-modal').removeClass '_opened'
          Meteor.setTimeout ->
            Meteor.call 'addEvent', alias, title, date, (err, res)->
              if err
                console.log err

              else
                Router.go 'eventPage', {
                    alias: res
                  }
                , 400
        else
          Aura.notify 'Ссылка должна быть сплошной строкой без пробелов=('
      else
        Aura.notify 'Запись с таким именем уже существует=('
    else
      Aura.notify 'Пожалуйста заполните все поля формы'

}


Template.newsItemCreateModal.rendered = ->

  Meteor.defer ->
    @.$('#news-item-create-modal').addClass '_opened'


Template.newsItemCreateModal.events {

  'click button': (e)->
    title = $('#news-item-title').val()
    date = Date.parse(new Date($('#news-item-date').val()))

    $('#news-item-create-modal').removeClass '_opened'
    Meteor.setTimeout ->
      Meteor.call 'addNewsItem', title, date, (err, res)->
        if err
          console.log err

        else
          Meteor.defer ->
            $('#news').find('.item').last().prev().trigger('click')
          console.log 'news item added'


  'click .remove': (e)->
    $(e.currentTarget).closest('#news-item-create-modal').removeClass '_opened'

}