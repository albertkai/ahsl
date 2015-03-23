(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.Schedules = new Meteor.Collection('schedules');

Schedules.allow({
  insert: function() {
    return true;
  },
  update: function() {
    return true;
  }
});

})();

//# sourceMappingURL=schedules_coll.coffee.js.map
