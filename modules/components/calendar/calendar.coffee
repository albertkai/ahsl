if Meteor.isClient

  class @Calendar

    group: null
    hours:
      day: ['12:00 - 12:45', '13:00 - 13:45', '14:00 - 14:45']
      evening: ['17:00 - 17:45', '18:00 - 18:45', '19:00 - 19:45']
    month: new Date().getMonth()
    year: new Date().getYear()
    header: '<div class="header"><div>Время</div><div>ПН</div><div>ВТ</div><div>СР</div><div>ЧТ</div><div>ПТ</div><div>СБ</div><div>ВС</div></div>'
    groups: '<div class="container group-change-cont"><div class="row"><div><button class="lead _active" data-group="children">Детская группа</button></div><div><button class="lead" data-group="teens" data-time="true">Школьная группа</button></div><div><button class="lead" data-group="lateTeens">Подростковая группа</button></div><div><button class="lead" data-group="grownUps">Взрослая группа</button></div></div></div>'
    groupTimes: '<div class="container group-time"><div class="chckbx _active" data-group="teens_day"><div><div></div></div><p>Дневная группа</p></div><div class="chckbx" data-group="teens_evening"><div><div></div></div><p>Вечерняя группа</p></div></div>'
    months: ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь']
    drawGroups: true
    saveTimeout: null

    constructor: (element, options)->

      if !element
        console.log 'Need to provide target element to Aura::calendar'
      @el = element
      if options
        @group = options.group
        @hours = @hours[options.hours] or @hours.evening
        @month = options.month or @month
        @year = options.year or @year
        @drawGroups = options.drawGroups if options.drawGroups?

      console.log @group
      console.log @month
      console.log @year
      console.log @hours
      console.log options.drawGroups
      @init()

    init: ->

      @schedule = Schedules.findOne({'group': @group}).schedule
      @_draw()


      #Events

      $('body').find(@el).find('.calendar-controls .arrows').find('button:nth-child(2)').on 'click', (e)=>
        month = parseInt @month
        @month = do =>
          if month > 11
            @year = @year + 1
            0
          else
            month + 1

        @_hideCalendar()
        @_hideControls()

        Meteor.setTimeout =>
          @_redrawCalendar()
          @_redrawControls()
          Meteor.setTimeout =>
            @_showCalendar()
            @_showControls()
          , 100
        , 400

      $('body').find(@el).find('.calendar-controls .arrows').find('button:nth-child(1)').on 'click', (e)=>
        month = parseInt @month
        @month = do =>
          if month - 2 < 0
            @year = @year - 1
            11
          else
            month - 1

        @_hideCalendar()
        @_hideControls()

        Meteor.setTimeout =>
          @_redrawCalendar()
          @_redrawControls()
          Meteor.setTimeout =>
            @_showCalendar()
            @_showControls()
          , 100
        , 400

      $('body').find(@el).find('.group-change-cont').find('button').on 'click', (e)=>
        target = $(e.currentTarget).data('group')
        if !$(e.currentTarget).data('time') or $(e.currentTarget).data('time') is ''
          $('.group-time').removeClass '_visible'
        else
          $('.group-time').addClass '_visible'
        $('body').find(@el).find('.group-change-cont').find('button').removeClass '_active'
        $(e.currentTarget).addClass '_active'
        @schedule = Schedules.findOne({'group': target}).schedule
        @_redrawCalendar()

      $('body').find('.calendar').find('[contenteditable="true"]').on 'input', (e)=>
        Meteor.clearTimeout @saveTimeout
        @saveTimeout = Meteor.setTimeout =>
          $target = $(e.currentTarget)
          content = []
          $target.closest('[data-day]').find('[contenteditable="true"]').each ->
            content.push $(this).html()
          day = $target.closest('[data-day]').data('day')
          month = $target.closest('[data-month]').data('month')
          index = $target.closest('div').index()
          console.log content
          console.log day
          console.log month
          console.log @year
          console.log @group
          Meteor.call 'updateSchedule', content, day, month, @group, index, (err, res)->
            if err
              console.log err
            else
              Aura.notify 'Расписание изменено!'
        , 1500



    _draw: ->

      heading = @_drawHeading()
      calendar = @_drawCalendar()
      markup = '<div class="container"><div class="calendar" data-month="' + @month + '">' + heading + '<div class="body">' + calendar + '</div></div></div>'
      $(@el).html(markup)
      @_showCalendar()
      @_showControls()

    _drawHeading: ->
      console.log @drawGroups
      controls = @_drawControls()
      markup = ''
      if @drawGroups is true
        markup += @groups
      markup += @groupTimes
      markup += '<div class="container calendar-controls">'
      markup += controls
      markup += '<div class="arrows small"><button></button><button></button></div></div>'
      markup += @header
      markup

    _drawCalendar: ->

      aside = @__drawAside()
      output = @__drawOutput()
      body = aside + output
      body

    _redrawCalendar: ->

      newCalendar = @_drawCalendar()
      $(@el).find('.body').html(newCalendar)

    _redrawControls: ->

      markup = '<span>' + (@year + 1900) + '</span><span>' + @months[(@month - 1)] + '</span>'
      $(@el).find('.calendar-controls > p').html(markup)


    _drawControls: ->

      markup = '<p>'
      markup += '<span>' + (@year + 1900) + '</span>'
      markup += '<span>' + @months[@month - 1] + '</span>'
      markup += '</p><div class="arrows small" data-year="' + @year + ' " data-month="' + @month + '"><button></button><button></button></div>'
      markup


    __drawAside: ->

      markup = '<aside>'
      for num in [1..6]
        markup += '<div><div>' + @hours[0] + '</div><div>' + @hours[1] + '</div><div>' + @hours[2] + '</div></div>'
      markup += '</aside>'
      markup

    __drawOutput: ->

      today = new Date().getDate()
      furtherMonth = @month - 1
      firstDay = new Date(@year, furtherMonth , 1).getDay()
      lastDay = new Date(@year, @month , 0).getDate()
      console.log @year
      console.log @month
      console.log firstDay
      console.log lastDay
      counter = 1
      markup = '<div class="output" data-group="' + @group + '">'
      for row in [1...7]
        markup += '<div class="calendar-row">'
        for cell in [1..7]
          markup += @__drawCell(firstDay, counter, lastDay, today)
          counter++
        markup += '</div>'
      markup += '</div></div>'
      markup



    __drawCell: (startDay, day, lastDay, today)->

      if day < (startDay + 2) or day > (lastDay + startDay + 1)
        '<div class="_disabled"></div>'
      else
        todayClass = do ->
          if (day - 1) is today
            'class="today"'
          else
            ''
        markup = '<div ' + todayClass + 'data-day="' + (day - startDay - 1) + '"><span class="date">' + (day - startDay - 1) + '</span><div>'
        for num in [0..2]
          if @schedule[@month]
            if @schedule[@month][day]
              markup += '<div><p><span contenteditable="true">' + @schedule[@month][day][num] + '</span></<p></p></div>'
            else
              markup += '<div><p><span contenteditable="true"> </span></p></div>'
          else
            console.log 'Aura::calendar: No schedule for this month:('
        markup += '</div></div>'
        markup


    _showCalendar: ->

      $(@el).find('.body').addClass '_visible'

    _showControls: ->

      $(@el).find('.calendar-controls').addClass '_visible'

    _hideCalendar: ->

      $(@el).find('.body').removeClass '_visible'

    _hideControls: ->

      $(@el).find('.calendar-controls').removeClass '_visible'


    _setMonth: (month)->

      @month = month

    _setYear: (year)->

      @year = year

    _setGroup: (group)->

      @group = group


if Meteor.isServer

  Meteor.methods {

    'updateSchedule': (content, day, month, group)->

      query = {}
      queryString = 'schedule.' + month + '.' + (day + 5)
      query[queryString] = content
      Schedules.update {group: group}, {$set: query}
      console.log Schedules.findOne {group: group}
      console.log query

  }



