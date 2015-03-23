Template.news.rendered = ->
  #

Template.news.events {

  'click [data-id]': (e)->

    console.log 'clicked'

    id = $(e.currentTarget).data('id')

    if $(e.target).parent('.remove').length is 0 and !$(e.target).hasClass('remove')

      console.log  News.findOne({_id: id})

      if NewsCtrl.openedModal
        Blaze.remove NewsCtrl.openedModal

      NewsCtrl.openedModal = Blaze.renderWithData Template.newsItemOpened, News.findOne({_id: id}), document.body

    else

      Meteor.call 'removeNewsItem', id
}

Template.news.helpers {

  news: ->
    News.find()

}


Template.newsItemOpened.rendered = ->

  $('#newsModal').modal 'show'

Meteor.startup ->

  $('body').on 'click', '[data-add-news-item]', (e)->

    console.log 'clicked'

    if !NewsCtrl.newsItemCreateModal
      NewsCtrl.newsItemCreateModal = Blaze.render Template.newsItemCreateModal, document.body
    else
      $('#news-item-create-modal').addClass('_opened')

Template.news.helpers {}

Template.registerHelper 'getCurrentNew', ->

  if AuraPages.findOne({name: 'news'})

    AuraPages.findOne({name: 'news'}).news[0]


@NewsCtrl = {

  newsItemCreateModal: null

  openedModal: null

}