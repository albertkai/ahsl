Template.blog.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  $('select').select2({
    minimumResultsForSearch: -1
  })

  tags = []

  BlogTags.find().fetch().forEach (t)->
    tags.push {
      text: t.name
      weight: t.count
      html: {
        class: 'tag-item'
      }
    }
  console.log tags

  $("#tags-cont").jQCloud(tags)

Template.blog.events {

}



Template.blogPage.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  $.stellar()