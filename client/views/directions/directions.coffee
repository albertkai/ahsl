Template.children.rendered = ->

  console.log 'children rendered'

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  new Calendar('#group-schedule', {
    group: 'children'
    month: '11'
    drawGroups: false
  })

  Meteor.setTimeout ->
    $('body').stellar()
  , 1000

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'



Template.children.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

}

Template.teens.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  new Calendar('#group-schedule', {
    group: 'teens_day'
    month: '11'
    drawGroups: false
  })

  Meteor.setTimeout ->
    $('body').stellar()
  , 1000

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.teens.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

}

Template.lateteens.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  new Calendar('#group-schedule', {
    group: 'lateTeens'
    month: '11'
    drawGroups: false
  })

  Meteor.setTimeout ->
    $('body').stellar()
  , 1000

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.lateteens.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

}


Template.grownups.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  new Calendar('#group-schedule', {
    group: 'grownUps'
    month: '11'
    drawGroups: false
  })

  Meteor.setTimeout ->
    $('body').stellar()
  , 1000

  $('.custom-tab').first().addClass '_active'
  $('.classes-header .row > div').first().addClass '_active'

Template.grownups.events {

  'click .classes-header .row > div button': (e)->

    index = $(e.currentTarget).parent().index()
    $(e.currentTarget).addClass('_active').parent().siblings().find('button').removeClass('_active')
    $('.custom-tab').removeClass('_active')
    $('.custom-tab').eq(index).addClass('_active')

}