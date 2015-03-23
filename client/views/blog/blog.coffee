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

  $("#tags-cont").jQCloud(tags)


Template.blog.events {

  'change [data-select-bloglist-category]': (e)->

    Session.set('auraBlogListCategory', $(e.currentTarget).val())



  'change [data-select-bloglist-sort]': (e)->

    Session.set('auraBlogListSort', $(e.currentTarget).val())

}


Template.blogPage.helpers {

  'getTagName': (id)->
    if BlogTags.findOne({_id: id})
      BlogTags.findOne({_id: id}).name

  'getPageId': ->
    _.random(0, 1000000)

  'settings': ->

    {
      position: "bottom",
      limit: 5,
      rules: [
        {
          collection: BlogTags,
          field: 'name',
          template: Template.tagAutocomplete
          callback: (doc, $el)->
            $el.trigger($.Event( "keypress", { which: 13 } ))
        },
      ]
    }

}

Template.blogPage.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  $.stellar()
