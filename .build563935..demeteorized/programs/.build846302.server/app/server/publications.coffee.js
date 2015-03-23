(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.publish('schedules', function() {
  return Schedules.find();
});

Meteor.publish('events', function() {
  return Events.find();
});

Meteor.publish('news', function() {
  return News.find();
});

Meteor.publish('requests', function() {
  return Requests.find();
});

Meteor.publish('slider', function() {
  return Slider.find();
});

Meteor.publish('summerSlider', function() {
  return SummerSlider.find();
});

})();

//# sourceMappingURL=publications.coffee.js.map
