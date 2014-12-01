Meteor.publish 'schedules', ->
  Schedules.find()

Meteor.publish 'events', ->
  Events.find()
