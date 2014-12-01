Meteor.methods {

  addEvent: (alias, title, date)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      Events.insert {
        alias: alias
        title: title
        date: date
        mainDesc: 'Полное описание программы события'
        shortDesc: 'Краткое описание события'
        place: 'место проведения'
        price: '10000р'
        time: '12:00'
        pic: ''
      }

      alias

    else

      console.log 'permission denied'

  removeEvent: (alias)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      Events.remove {'_id': Events.findOne({alias: alias})._id}

}