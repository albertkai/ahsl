(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Router.configure({
  loadingTemplate: 'loading'
});

Router.map(function() {
  this.route('index', {
    path: '/',
    template: 'mainLayout',
    waitOn: function() {
      return Meteor.subscribe('schedules');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('children', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('schedules');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('teens', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('schedules');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('summer', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('summerSlider');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('lateteens', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('schedules');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('international', {
    layoutTemplate: 'innerLayout',
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('masterclass', {
    layoutTemplate: 'innerLayout',
    template: 'masterClassesList',
    waitOn: function() {
      return Meteor.subscribe('events');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('news', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('news');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('grownups', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('schedules');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('events', {
    layoutTemplate: 'innerLayout',
    template: 'eventsList',
    waitOn: function() {
      return Meteor.subscribe('events');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('eventPage', {
    path: 'event/:alias',
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('events');
    },
    data: function() {
      return Events.findOne({
        alias: this.params.alias
      });
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  this.route('gallery', {
    path: 'gallery',
    layoutTemplate: 'innerLayout',
    template: 'gallery'
  });
  this.route('schedule', {
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('schedules');
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  return this.route('contacts', {
    path: 'contacts',
    layoutTemplate: 'innerLayout',
    template: 'contacts'
  });
});

Router.onAfterAction(function() {
  document.body.scrollTop = 0;
  return Meteor.setTimeout(function() {
    if (Session.get('admin.editMode') === true) {
      return $('[contenteditable]').each(function() {
        return $(this).attr('contenteditable', 'true');
      });
    }
  }, 1000);
});

})();

//# sourceMappingURL=router.coffee.js.map
