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

    Meteor.call 'addEmailToBase', email

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


#Prostoemail API integration


  createMailing: (name, subject, bases, html)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      options = {
        username: process.env.EMAIL_USER
        password: process.env.EMAIL_PASS
        method: 'campaigns.create'
        list_id: bases
        name: name
        subject: subject
        from_name: 'Austrian Higher School of Ladies'
        from_email: 'maria@sisi-elizabeth.com'
        html: html
      }


#      str = 'http://api.prostoemail.ru/?' + getParams
#
#      f = new Future()
#
#      result = HTTP.get str, (err, result)->
#        issue = JSON.parse(result.content)
#        console.log(issue)
#        f.return(issue.response.data.campaign_id)
#
#      f.wait()

      str = 'http://api.prostoemail.ru/'

      f = new Future()

      result = HTTP.post str, {params: options}, (err, result)->
        issue = JSON.parse(result.content)
        console.log(issue)
        f.return(issue.response.data.campaign_id)

      f.wait()

  getBasesList: ->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      options = {
        username: process.env.EMAIL_USER
        password: process.env.EMAIL_PASS
        method: 'lists.get'
  #      list_id: bases

      }

      getParams = ''

      for name, prop of options

        getParams += name + '=' + prop + '&'

      str = 'http://api.prostoemail.ru/?' + getParams

      f = new Future()

      result = HTTP.get str, (err, result)->
        bases = []
        issue = JSON.parse(result.content)
        issue.response.data.forEach (b)->
          bases.push {
            id: b.id,
            name: b.name,
            active: b.count_active,
            total: b.count_all
          }
        f.return(bases)

      f.wait()


  addEmailToBase: (email)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      options = {
        username: process.env.EMAIL_USER
        password: process.env.EMAIL_PASS
        method: 'lists.add_member'
        list_id: 260371
        email: email

      }

      getParams = ''

      for name, prop of options

        getParams += name + '=' + prop + '&'

      str = 'http://api.prostoemail.ru/?' + getParams
      result = HTTP.get str, (err, result)->
        issue = JSON.parse(result.content)
        console.log(issue)

  sendMailing: (id)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

      options = {
        username: process.env.EMAIL_USER
        password: process.env.EMAIL_PASS
        method: 'campaigns.update'
        campaign_id: id
        status: 'MODERATING'

      }

      getParams = ''

      for name, prop of options

        getParams += name + '=' + prop + '&'

      str = 'http://api.prostoemail.ru/?' + getParams
      result = HTTP.get str, (err, result)->
        issue = JSON.parse(result.content)
        console.log(issue)




#Helper method for saving requests DB as CSV


  saveCSV: ->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

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