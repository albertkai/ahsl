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

  sendRequestEmail: (header, text, to)->

    if to? then toAddress = to else toAddress = ["info@sisi-elizabeth.com", "maria-skr-rt@mail.ru", "albertkai@me.com"]

    Email.send({
      from: "info@ladies-school.com",
      to: toAddress,
      subject: header,
      text: text
    })

  addReview: (pic)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
      page = AuraPages.findOne({name: 'reviews'})
      reviews = page.reviews
      reviews.push({pic: pic, order: reviews.length + 1, _id: Random.id()})
      AuraPages.update page._id, {$set: {reviews: reviews}}

  updateReviews: (reviews)->

    if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
      page = AuraPages.findOne({name: 'reviews'})
      AuraPages.update page._id, {$set: {reviews: reviews}}


  sendTransactionalEmail: (options)->

    console.log 'sending transactional email'

    if options.type is 'cash1'

      header = 'Подтверждение заказа на ladies-school.com'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим, за то, что вы сделали заявку на мастер-класс ' + options.title + ', который пройдет ' + options.date + ' по адресу: ' + options.place + '. Время: ' + options.time + '</p> <p>Вы выбрали способ оплаты – <strong>курьер</strong> (стоимость услуги 250 рублей).</p><p>Продолжительность  мастер-класса - 3 часа.</p> <p>Посещение мастер-класса возможно только при предварительной оплате. </p><p>Наш менеджер свяжется с вами для уточнения места и времени приезда курьера.</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'
      Email.send({
        from: "info@ladies-school.com",
        to: [options.email],
        subject: header,
        html: html
      })
      true

    else if options.type is 'cash2'

      header = 'Подтверждение заказа на ladies-school.com'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим, за то, что вы сделали заявку на мастер-класс ' + options.title + ', который пройдет ' + options.date + ' по адресу: ' + options.place + '. Время: ' + options.time + '</p> <p>Вы решили <strong>самостоятельно приехать в школу и оплатить менеджеру</strong></p><p>Продолжительность  мастер-класса - 3 часа.</p> <p>Посещение мастер-класса возможно только при предварительной оплате. </p><p>Наш менеджер свяжется с вами для уточнения времени встречи</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'

      Email.send({
        from: "info@ladies-school.com",
        to: [options.email],
        subject: header,
        html: html
      })
      true


  extendDiscount: (field)->

    console.log('field')

    currentDiscount = AuraPages.findOne({name: 'onlineSchool'})[field]
    if currentDiscount < Date.now()
      query = {}
      query[field] = currentDiscount + 172800000
      AuraPages.update({name: 'onlineSchool'}, {$set: query})



  sendOnlineTransactionalEmail: (options)->

    console.log 'sending transactional email'

    header = 'Подтверждение заказа на ladies-school.com'
    if options.pack is 'standard'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим Вас за покупку Начального курса</p><p>Наш менеджер свяжется с вами для уточнения деталей</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'
    else if options.pack is 'gold'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим, за то, что вы сделали заявку на приобретение пакета "Gold".</p><p>Наш менеджер свяжется с вами для уточнения деталей</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'
    if options.pack is 'platinum'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим Вас за покупку Базового курса.</p><p>Наш менеджер свяжется с вами для уточнения деталей</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'
    if options.pack is 'vip'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим, за то, что вы сделали заявку на приобретение пакета "VIP".</p><p>Наш менеджер свяжется с вами для уточнения деталей</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'
    if options.pack is 'individual'
      html = '<h2>' + options.name + ', доброго времени суток!</h2><p>Благодарим Вас за покупку Индивидуального курса.</p><p>Наш менеджер свяжется с вами для уточнения деталей</p><p>Благодарим Вас за обращение в «Австрийскую Высшую Школу Этикета»!</p>'
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
        from_name: 'Мария Бастрыкина'
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
        if !err
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


  vote: (id, fingerprint)->

    ip = @connection.clientAddress
    console.log('Voting for ' + id)
    console.log('IP ' + ip)
    if Voted.find({ip: ip}).count() is 0
      console.log 'Can vote'
      Girls.update id, {$inc: {votes: 1}}

      Voted.insert {
        ip: ip,
        date: Date.now()
        fingerprint: fingerprint,
        id: id
      }
      true
    else
      console.log 'Cant vote'
      false


  setVote: (id, count)->

    if @userId?
      console.log('setting vote')
      Girls.update id, {$set: {votes: count}}

  setText: (id, text)->

    if @userId?
      console.log('setting text')
      Girls.update id, {$set: {text: text}}

  getTrueVotes: (timePeriod)->

    f = new Future()
    sorted = []
    Girls.find().forEach (g)->
      sorted.push {
        name: g.surname
        votes: Voted.find({id: g._id}, {sort: {date: 1}}).fetch()
      }
    deduplicate = []
    sorted.forEach (s)->
      fingerprints = []
      duplicates = 0
      votesProcessed = []
      s.votes.forEach (v)->
        unless _.contains fingerprints, v.fingerprint
          votesProcessed.push v
          fingerprints.push v.fingerprint
        else
          duplicates++
      deduplicate.push {
        name: s.name
        votes: votesProcessed
        duplicates: duplicates
      }
    result = ''
    deduplicate.forEach (i)->
      result += i.name + ': '
      count = 0
      bot = 0
      i.votes.forEach (vot, index)->
        if i.votes[index + 1]?
          if i.votes[index + 1].date - vot.date > timePeriod
            count++
          else
            bot++
      result += count + '\n'
      result += 'Подозрения по времени: ' + bot + '\n'
      result += 'Подозрения по браузерам: ' + i.duplicates + '\n'
      result += '\n'
    f.return(result)
    f.wait()







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