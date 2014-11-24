Template.news.rendered = ->
  #

Template.news.events {

  'click .item': ->

    $('#newsModal').modal('show')

}

Template.news.helpers {}

Template.registerHelper 'getCurrentNew', ->

  if AuraPages.findOne({name: 'news'})

    AuraPages.findOne({name: 'news'}).news[0]