(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.Events = new Mongo.Collection('events');

this.News = new Mongo.Collection('news');

this.Requests = new Mongo.Collection('requests');

this.Slider = new Mongo.Collection('slider');

this.SummerSlider = new Mongo.Collection('summerSlider');

Slider.allow({
  insert: function(userId) {
    if (userId) {
      return true;
    }
  },
  update: function(userId) {
    if (userId) {
      return true;
    }
  },
  remove: function(userId) {
    if (userId) {
      return true;
    }
  }
});

SummerSlider.allow({
  insert: function(userId) {
    if (userId) {
      return true;
    }
  },
  update: function(userId) {
    if (userId) {
      return true;
    }
  },
  remove: function(userId) {
    if (userId) {
      return true;
    }
  }
});

Events.allow({
  insert: function(userId) {
    if (userId) {
      return true;
    }
  },
  update: function(userId) {
    if (userId) {
      return true;
    }
  },
  remove: function(userId) {
    if (userId) {
      return true;
    }
  }
});

AuraColl['events'] = Events;

AuraColl['news'] = News;

AuraColl['requests'] = Requests;

AuraColl['slider'] = Slider;

AuraColl['summerSlider'] = SummerSlider;

})();

//# sourceMappingURL=collections.coffee.js.map
