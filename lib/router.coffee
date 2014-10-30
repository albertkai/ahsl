Router.map ->

  @route 'index', {
    path: '/'
    template: 'mainLayout'
    waitOn: ->
      Meteor.subscribe('schedules')
  }

  @route 'direction', {
    path: 'direction'
    layoutTemplate: 'innerLayout'
    template: 'direction'
    waitOn: ->
      Meteor.subscribe('schedules')
  }

  @route 'gallery', {
    path: 'gallery'
    layoutTemplate: 'innerLayout'
    template: 'gallery'

  }

  @route 'contacts', {
    path: 'contacts'
    layoutTemplate: 'innerLayout'
    template: 'contacts'

  }

  @route 'blog', {
    path: 'blog'
    layoutTemplate: 'innerLayout'
    template: 'blog'

  }


Router.onAfterAction ->

  document.body.scrollTop = 0
