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

Meteor.publish 'sochiSlider', ->
  SochiSlider.find()

Meteor.publish 'girls', ->
  Girls.find()

Meteor.publish 'voted', ->
  Voted.find()
