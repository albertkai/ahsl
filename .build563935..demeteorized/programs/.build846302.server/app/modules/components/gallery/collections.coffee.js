(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.AuraGallery = new Mongo.Collection('auraGallery');

AuraColl['auraGallery'] = AuraGallery;

AuraGallery.allow({
  insert: function(userId) {
    if (Roles.userIsInRole(userId, ['admin'])) {
      return true;
    }
  },
  update: function(userId) {
    if (Roles.userIsInRole(userId, ['admin'])) {
      return true;
    }
  },
  remove: function(userId) {
    if (Roles.userIsInRole(userId, ['admin'])) {
      return true;
    }
  }
});

})();

//# sourceMappingURL=collections.coffee.js.map
