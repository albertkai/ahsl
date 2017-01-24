Router.configure({
  loadingTemplate: 'loading'
})

Router.route 'index', {
  path: '/'
  template: 'mainLayout'
  waitOn: ->
    Meteor.subscribe('slider')
  action: ->
    if @ready()
      @render()
}

Router.route 'children', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
#      Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'reviews', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
#      Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'blog', {
  layoutTemplate: 'innerLayout'
}

#Router.route 'thank-you-signin', {
#  template: 'thankYouSignup'
#}
#
#Router.route 'thank-you-payment', {
#  template: 'thankYouPayment'
#}

Router.route 'teens', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
#      Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'lessons', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
#      Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'summer-school', {
  layoutTemplate: 'innerLayout'
  template: 'summerSchool'
  waitOn: ->
    Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
  onAfterAction: ->
    if Meteor.isClient
      doc = AuraPages.findOne({name: 'summerSchool'})
      if doc
        SEO.set({
          title: 'Austrian Higher School of Etiquette | Летняя школа',
          meta: {
            'description':  doc.mainDesc
          },
          og: {
            'title': 'Летняя щкола',
            'description': doc.mainDesc,
            'url': 'http://ladies-school.com/summer',
            'type': 'article',
            'image': 'http://d1tvqt3gjtui5j.cloudfront.net/images/' + doc.mainPic
          }
        })
}

Router.route 'summer', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('summerSlider')
  action: ->
    if @ready()
      @render()
}

Router.route 'sochi', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('sochiSlider')
  action: ->
    if @ready()
      @render()
}

Router.route 'lateteens', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
#      Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'online', {
  template: 'onlineSchool'
  layoutTemplate: 'innerLayout'
  data: ->
    doc = AuraPages.findOne({name: 'onlineSchool'})
    if doc
      {
        url: 'http://ladies-school.com',
        title: 'Austrian Higher School of Etiquette',
        desc: 'Онлайн обучение в Австрийской высшей школе Этикета',
        img: doc.mainPic
      }
    else {}
  waitOn: ->
#      Meteor.subscribe('schedules')
  onAfterAction: ->
    if Meteor.isClient
      doc = AuraPages.findOne({name: 'onlineSchool'})
      if doc
        SEO.set({
          title: 'Austrian Higher School of Etiquette | Онлайн обучение',
          meta: {
            'description': 'Обучение онлайн в Австрийской Высшей школе Этикета'
          },
          og: {
            'title': 'Австрийская высшая школа этикета',
            'description': 'Обучение онлайн в Австрийской Высшей школе Этикета',
            'url': 'http://ladies-school.com/online',
            'type': 'article',
            'image': 'http://d1tvqt3gjtui5j.cloudfront.net/images/' + doc.mainPic
          }
        })
  action: ->
    if @ready()
      @render()
}

Router.route 'cinema',
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('girls')
  action: ->
    if @ready()
      @render()

Router.route 'country', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('countrySlider')
  action: ->
    if @ready()
      @render()
}

Router.route 'international', {
  layoutTemplate: 'innerLayout'
  action: ->
    if @ready()
      @render()
}

Router.route 'masterclass', {
  layoutTemplate: 'innerLayout'
  template: 'masterClassesList'
  waitOn: ->
    Meteor.subscribe('events')
  action: ->
    if @ready()
      @render()
}

Router.route 'masterclass_partners', {
  layoutTemplate: 'innerLayout'
  template: 'masterClassesListSochi'
  waitOn: ->
    Meteor.subscribe('events')
  action: ->
    if @ready()
      @render()
}

Router.route 'news', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('news')
  action: ->
    if @ready()
      @render()
}

Router.route 'grownups', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
#      Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'events', {
  layoutTemplate: 'innerLayout'
  template: 'eventsList'
  waitOn: ->
    Meteor.subscribe('events')
  action: ->
    if @ready()
      @render()
}

Router.route 'eventPage', {
  path: 'event/:alias'
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('events')
  data: ->
    Events.findOne({alias: @params.alias})
  action: ->
    if @ready()
      @render()
  onAfterAction: ->
    if Meteor.isClient
      doc = Events.findOne({alias: @params.alias})
      if doc
        SEO.set({
          title: 'Austrian Higher School of Etiquette | ' + doc.title,
          meta: {
            'description':  doc.desc
          },
          og: {
            'title': doc.title,
            'description': doc.desc,
            'url': 'http://ladies-school.com/event/' + doc.alias,
            'type': 'article',
            'image': 'http://d1tvqt3gjtui5j.cloudfront.net/images/' + doc.pic
          }
        })
}

Router.route 'gallery', {
  path: 'gallery'
  layoutTemplate: 'innerLayout'
  template: 'gallery'

}

Router.route 'schedule', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('schedules')
  action: ->
    if @ready()
      @render()
}

Router.route 'archive', {
  layoutTemplate: 'innerLayout'
  waitOn: ->
    Meteor.subscribe('events')
  action: ->
    if @ready()
      @render()
}

Router.route 'kindergarten', {
  layoutTemplate: 'innerLayout'
#  waitOn: ->
#    Meteor.subscribe('eve')
#  action: ->
#    if @ready()
#      @render()
}

Router.route 'contacts', {
  path: 'contacts'
  layoutTemplate: 'innerLayout'
  template: 'contacts'
}

Router.route 'paymentAccepted', {
  layoutTemplate: 'innerLayout'
}

Router.route 'success', {
  template: 'mainLayout'
  waitOn: ->
    Meteor.subscribe('slider')
  onAfterAction: ->
    Blaze.render Template.successWindow, document.body
    fbq('track', 'Purchase', {value: '100.00', currency: 'USD'})
    yaCounter27185078.reachGoal('Purchase')

  action: ->
    if @ready()
      @render()
}

Router.route 'api/paymentSuccess', {
  action: ->

    console.log 'callbackUrl called'
    console.log 'string:'
    console.log(@params.query)
    requestId = @params.query.OrderId
    request = Requests.findOne({requestId: requestId})
    console.log request
    name = request.name
    email = request.email
    title = request.title
    date = request.eventDate
    place = request.place
    time = request.eventTime
    type = request.eventType

    Meteor.call('sendRequestEmail', 'Прошла оплата по заявке', "Имя: #{ request.name }, \n Email: #{ request.email } \n Заголовок: #{ request.title } \n Тип: #{ request.type }")

    if type is 'webinar'
      link = request.additional.link
      password = request.additional.pass

    console.log 'Тип:'
    console.log type

    if type is 'webinar'

      console.log 'Starting webinar machinery'
      console.log email

      html = '<h2>' + name + ', доброго времени суток!</h2><p>Благодарим Вас за оплату вебинара <strong>' + title + '</strong>, который пройдет <strong>' + date + ' ' + time + '</strong></p> <p>Продолжительность - 3 часа.</p> <p>Для участия в вебинаре, в указанное время, перейдите по ссылке: <strong>' + link + '</strong> и введите пароль: <strong>' + password + '</strong> </p><p>Если возникнут какие-либо вопросы, то свяжитесь с нами по номеру <strong>(812) 984-30-88</strong></p> <p>Благодарим Вас за покупку нашего вебинара!</p><p>C уважением, персонал «Austrian Higher School of Ladies»!</p>'
      Email.send({
        from: "info@ladies-school.com",
        to: email,
        subject: 'Покупка в Austrian Higher School of Ladies',
        html: html
      })
      @response.end(JSON.stringify(@params.query))

    else if type is 'video'

      html = '<h2>' + name + ', доброго времени суток!</h2><p>Благодарим Вас за покупку видео-лекции <strong><p>Для того, чтобы скачать вашу лекцию, перейдите по ссылке: <strong>' + link + '</strong> и введите пароль: <strong>' + password + '</strong> </p><p>Если возникнут какие-либо вопросы, то свяжитесь с нами по номеру <strong>(812) 984-30-88</strong></p> <p>Спасибо за покупку!</p><p>C уважением, персонал «Austrian Higher School of Ladies»!</p>'
      Email.send({
        from: "info@ladies-school.com",
        to: email,
        subject: 'Покупка в Austrian Higher School of Ladies',
        html: html
      })
      @response.end(JSON.stringify(@params.query))

    else if type is 'masterclass'

      html = '<h2>' + name + ', доброго времени суток!</h2><p>Благодарим Вас за покупку мастер-класса ' + title + ', который пройдет ' + date + ' по адресу: ' + place + '. Время: ' + time + '</p> <p>Вы решили <strong>самостоятельно приехать в школу и оплатить менеджеру</strong></p><p>Продолжительность мастер-класса - 3 часа.</p> <p>Если возникнут какие-либо вопросы, то свяжитесь с нами по номеру <strong>(812) 984-30-88</strong></p> <p>Спасибо за покупку!</p><p>C уважением, персонал «Austrian Higher School of Ladies»!</p>'
      Email.send({
        from: "info@ladies-school.com",
        to: email,
        subject: 'Покупка в Austrian Higher School of Ladies',
        html: html
      })

    Requests.update {'_id': request._id}, {$set: {paymentStatus: 'received'}}
    console.log request._id

    @response.end(JSON.stringify(@params.query))

  where: 'server'
}




# Generated by aura CLI


Router.onAfterAction ->

  if Meteor.isClient

    currentRoute = Session.get('currentActiveRoute')
    if currentRoute isnt Router.current().location.get().href
      document.body.scrollTop = 0
    Session.set('currentActiveRoute', Router.current().location.get().href)
    Meteor.setTimeout ->
      if Session.get('admin.editMode') is true
        $('[contenteditable]').each ->
          $(this).attr('contenteditable', 'true')

    , 1000

    $('.wrap, .side-menu').removeClass '_shifted'

#end