(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.methods({
  addEvent: function(alias, title, date) {
    if (Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])) {
      Events.insert({
        alias: alias,
        title: title,
        date: date,
        mainDesc: 'Полное описание программы события',
        shortDesc: 'Краткое описание события',
        place: 'место проведения',
        price: '10000р',
        time: '12:00',
        pic: ''
      });
      return alias;
    } else {
      return console.log('permission denied');
    }
  },
  removeEvent: function(alias) {
    if (Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])) {
      return Events.remove({
        '_id': Events.findOne({
          alias: alias
        })._id
      });
    }
  },
  addNewsItem: function(title, date) {
    if (Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])) {
      return News.insert({
        title: title,
        date: date,
        mainDesc: 'Полное описание новости',
        shortDesc: 'Краткое описание новости',
        pic: ''
      });
    } else {
      return console.log('permission denied');
    }
  },
  removeNewsItem: function(id) {
    if (Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])) {
      return News.remove({
        '_id': id
      });
    }
  },
  addRequest: function(event, name, phone, email) {
    console.log('saving request');
    return Requests.insert({
      event: event,
      name: name,
      phone: phone,
      email: email
    });
  },
  sendRequestEmail: function(header, text) {
    return Email.send({
      from: "info@ladies-school.com",
      to: ["info.sisi-elizabeth@yandex.ru", "info@sisi-elizabeth.com", "maria-skr-rt@mail.ru"],
      subject: header,
      text: text
    });
  }
});

})();

//# sourceMappingURL=server.coffee.js.map
