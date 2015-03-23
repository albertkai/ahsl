Router.configure({
  loadingTemplate: 'loading'
})

Router.map ->

  @route 'index', {
    path: '/'
    template: 'mainLayout'
    waitOn: ->
      Meteor.subscribe('slider')
    action: ->
      if @ready()
        @render()
  }

  @route 'children', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
#      Meteor.subscribe('schedules')
    action: ->
      if @ready()
        @render()
  }

  @route 'teens', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
#      Meteor.subscribe('schedules')
    action: ->
      if @ready()
        @render()
  }

  @route 'summer-school', {
    layoutTemplate: 'innerLayout'
    template: 'summerSchool'
    waitOn: ->
      Meteor.subscribe('schedules')
    action: ->
      if @ready()
        @render()
  }

  @route 'summer', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
      Meteor.subscribe('summerSlider')
    action: ->
      if @ready()
        @render()
  }

  @route 'lateteens', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
#      Meteor.subscribe('schedules')
    action: ->
      if @ready()
        @render()
  }

  @route 'international', {
    layoutTemplate: 'innerLayout'
    action: ->
      if @ready()
        @render()
  }

  @route 'masterclass', {
    layoutTemplate: 'innerLayout'
    template: 'masterClassesList'
    waitOn: ->
      Meteor.subscribe('events')
    action: ->
      if @ready()
        @render()
  }

  @route 'news', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
      Meteor.subscribe('news')
    action: ->
      if @ready()
        @render()
  }

  @route 'grownups', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
#      Meteor.subscribe('schedules')
    action: ->
      if @ready()
        @render()
  }

  @route 'events', {
    layoutTemplate: 'innerLayout'
    template: 'eventsList'
    waitOn: ->
      Meteor.subscribe('events')
    action: ->
      if @ready()
        @render()
  }

  @route 'eventPage', {
    path: 'event/:alias'
    layoutTemplate: 'innerLayout'
    waitOn: ->
      Meteor.subscribe('events')
    data: ->
      Events.findOne({alias: @params.alias})
    action: ->
      if @ready()
        @render()
  }

  @route 'gallery', {
    path: 'gallery'
    layoutTemplate: 'innerLayout'
    template: 'gallery'

  }

  @route 'schedule', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
      Meteor.subscribe('schedules')
    action: ->
      if @ready()
        @render()
  }

  @route 'archive', {
    layoutTemplate: 'innerLayout'
    waitOn: ->
      Meteor.subscribe('events')
    action: ->
      if @ready()
        @render()
  }

  @route 'contacts', {
    path: 'contacts'
    layoutTemplate: 'innerLayout'
    template: 'contacts'
  }

  @route 'paymentAccepted', {
    layoutTemplate: 'innerLayout'
  }

  @route 'success', {
    template: 'mainLayout'
    waitOn: ->
      Meteor.subscribe('slider')
    onAfterAction: ->
      Blaze.render Template.successWindow, document.body

    action: ->
      if @ready()
        @render()
  }

  @route 'api/paymentSuccess', {
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

#      Email.send({
#        from: "info@ladies-school.com",
#        to: 'albertkai@me.com',
#        subject: 'Покупка в Austrian Higher School of Ladies',
#        html: JSON.stringify(@params.query)
#      })

      Requests.update {'_id': request._id}, {$set: {paymentStatus: 'received'}}
      console.log request._id

      @response.end(JSON.stringify(@params.query))

    where: 'server'
  }




# Generated by aura CLI


Router.onAfterAction ->

  if Meteor.isClient

    document.body.scrollTop = 0
    Meteor.setTimeout ->
      if Session.get('admin.editMode') is true
        $('[contenteditable]').each ->
          $(this).attr('contenteditable', 'true')

    , 1000

#end