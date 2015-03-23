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
        type: 'common'
        pic: ''
      }

      alias

    else

      console.log 'permission denied'

  removeEvent: (alias)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      Events.remove {'_id': Events.findOne({alias: alias})._id}

  addNewsItem: (title, date)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      News.insert {
        title: title
        date: date
        mainDesc: 'Полное описание новости'
        shortDesc: 'Краткое описание новости'
        pic: ''
      }

    else

      console.log 'permission denied'

  removeNewsItem: (id)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      News.remove {'_id': id}

  addRequest: (event, name, phone, email, type, eventType, eventDate, eventTime, place, requestId, additional, amount)->

    console.log 'saving request'

    console.log event
    console.log name
    console.log phone
    console.log email
    console.log type
    console.log requestId

    Requests.insert {

      event: event
      name: name
      phone: phone
      email: email
      title: event
      place: place
      requestId: requestId
      type: type
      eventType: eventType
      eventDate: eventDate
      eventTime: eventTime
      amount: amount
      paymentStatus: null
      status: 'unwatched'
      date: Date.parse(new Date)
      additional: additional

    }
    true

  sendRequestEmail: (header, text)->

    Email.send({
      from: "info@ladies-school.com",
      to: ["info.sisi-elizabeth@yandex.ru", "info@sisi-elizabeth.com", "maria-skr-rt@mail.ru"],
      subject: header,
      text: text
    })


  sendTransactionalEmail: (options)->

    console.log 'sending transactional email'

    if options.type is 'cash1'

      header = 'Подтверждение заказа на ladies-school.com'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим, за то, что вы сделали заявку на мастер-класс ' + options.title + ', который пройдет ' + options.date + ' по адресу: ' + options.place + '. Время: ' + options.time + '</p> <p>Вы выбрали способ оплаты – <strong>курьер</strong> (стоимость услуги 250 рублей).</p><p>Продолжительность  мастер-класса - 3 часа.</p> <p>Посещение мастер-класса возможно только при предварительной оплате. </p><p>Наш менеджер свяжется с вами для уточнения места и времени приезда курьера.</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Леди»!</p>'
      Email.send({
        from: "info@ladies-school.com",
        to: [options.email],
        subject: header,
        html: html
      })
      true

    else if options.type is 'cash2'

      header = 'Подтверждение заказа на ladies-school.com'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим, за то, что вы сделали заявку на мастер-класс ' + options.title + ', который пройдет ' + options.date + ' по адресу: ' + options.place + '. Время: ' + options.time + '</p> <p>Вы решили <strong>самостоятельно приехать в школу и оплатить менеджеру</strong></p><p>Продолжительность  мастер-класса - 3 часа.</p> <p>Посещение мастер-класса возможно только при предварительной оплате. </p><p>Наш менеджер свяжется с вами для уточнения времени встречи</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Леди»!</p>'

      Email.send({
        from: "info@ladies-school.com",
        to: [options.email],
        subject: header,
        html: html
      })
      true







  saveCSV: ->

    f = new Future()
    jszip = Meteor.npmRequire 'jszip'
    zip = new jszip()
    assetsFolder = zip.folder 'assets'
    fastCsv = Meteor.npmRequire 'fast-csv'
    requests = Requests.find({}, {fields: {'email': 1}}).fetch()
    csv = fastCsv
    csv.writeToString(requests,
      {headers: true},
      (error,data) ->
        if error
          console.log error
        else
          zip.file('friends.csv', data)
          file = zip.generate({type:"base64"})
          f.return(file)
    )
    f.wait()


#    fs = require('fs')
#    writeStream = fs.createWriteStream("base.xls")
#    data = Requests.find().fetch()
#    header = "Email"+"\t"+" Name"+"\t"+"Phone"+"\n"
#    writeStream.write header
#    data.forEach (r)->
#      writeStream.write(r.email + "\t"+ r.name +"\t"+ r.phone +"\n")
#    writeStream.close()

}


Router.onBeforeAction(Iron.Router.bodyParser.urlencoded({
  extended: false
}))