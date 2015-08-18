Meteor.publish 'schedules', ->
  Schedules.find()

Meteor.publish 'events', ->
  Events.find()

Meteor.publish 'news', ->
  News.find()

Meteor.publish 'requests', ->
  Requests.find()

Meteor.publish 'slider', ->
  Slider.find()

Meteor.publish 'summerSlider', ->
  SummerSlider.find()

Meteor.publish 'countrySlider', ->
  CountrySlider.find()
