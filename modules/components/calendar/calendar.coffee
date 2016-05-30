if Meteor.isClient

  class @Calendar

    group: null
    hourTimes:
      children: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30']
      teens_day: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30']
      lateTeens: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30']
      grownUps: ['11:00 - 11:45', '11:55 - 12:35', '12:45 - 13:30', '13:40 - 14:25', '14:35 - 15:10']
      onlineSchool: ['11:00 - 11:45', '11:55 - 12:35', '12:45 - 13:30', '13:40 - 14:25', '14:35 - 15:10']
      grownUps_evening: ['19:30 - 20:15', '20:25 - 21:10', '21:15 - 22:00']
      summerSchool: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30']
      summerSchool_evening: ['19:30 - 20:15', '20:25 - 21:10', '21:15 - 22:00']
    month: new Date().getMonth()
    year: new Date().getYear()
    header: '<div class="header"><div>Время</div><div>ПН</div><div>ВТ</div><div>СР</div><div>ЧТ</div><div>ПТ</div><div>СБ</div><div>ВС</div></div>'
    groups: '<div class="container group-change-cont"><div class="row"><div><button class="lead _active" data-group="children">Детская группа</button></div><div><button class="lead" data-group="teens_day">Школьная группа</button></div><div><button class="lead" data-group="lateTeens">Подростковая группа</button></div><div><button class="lead" data-group="grownUps" data-time="true">Взрослая группа</button></div></div></div>'
    groupTimes: '<div class="container group-time"><div class="chckbx _active" data-group="grownUps"><div><div></div></div><p>Дневная группа</p></div><div class="chckbx" data-group="grownUps_evening"><div><div></div></div><p>Вечерняя группа</p></div></div>'
    summerGroupTimes: '<div class="container group-time"><div class="chckbx _active" data-group="summerSchool"><div><div></div></div><p>Дневная группа</p></div><div class="chckbx" data-group="summerSchool_evening"><div><div></div></div><p>Вечерняя группа</p></div></div>'
    onlineGroupTimes: '<div class="container _visible group-time"><div class="chckbx _active" data-group="onlineSchool_morning"><div><div></div></div><p>Дневная группа</p></div><div class="chckbx" data-group="onlineSchool_evening"><div><div></div></div><p>Вечерняя группа</p></div><div class="chckbx" data-group="onlineSchool_weekend"><div><div></div></div><p>Группа выходного дня</p></div></div>'
    months: ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь']
    drawGroups: true
    chooseTime: false
    saveTimeout: null

    constructor: (element, options)->

      if !element
        console.log 'Need to provide target element to Aura::calendar'
      @el = element
      if options
        @group = options.group
        @hours = @hourTimes[@group]
        @month = options.month or @month
        @year = options.year or @year
        @drawGroups = options.drawGroups if options.drawGroups?
        @chooseTime = options.chooseTime if options.chooseTime?

      console.log @group
      console.log @month
      console.log @year
      console.log @hours
      console.log options.drawGroups
      @init()

    init: ->

      schedule = Schedules.findOne({'group': @group})
      @schedule = schedule.schedule
      @hours = schedule.times
      @_draw()

      Deps.autorun (c)->
        unless c.firstRun
          user = Meteor.user()
          if user?
            @_refresh()


      #Events

      $('body').find(@el).find('.calendar-controls .arrows').find('button:nth-child(2)').on 'click', (e)=>
        month = parseInt @month
        @month = do =>
          if month >= 11
            @year = @year + 1
            0
          else
            month + 1

        console.log 'month:'
        console.log @month

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
          if month - 1 < 0
            @year = @year - 1
            11
          else
            month - 1
        console.log @month

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

      $('body').find(@el).on 'click', '.group-change-cont button', (e)=>
        target = $(e.currentTarget).data('group')
        $('body').find(@el).find('.group-change-cont').find('button').removeClass '_active'
        $(e.currentTarget).addClass '_active'
        if !$(e.currentTarget).data('time') or $(e.currentTarget).data('time') is ''
          $('.group-time').removeClass '_visible'
          @group = target
          schedule = Schedules.findOne({'group': target})
          @schedule = schedule.schedule
          @hours = schedule.times
          @_redrawCalendar()
        else
          $('.group-time').addClass '_visible'
          $('.group-time').find('.chckbx').find('div').first().trigger 'click'

      $('body').on 'click', '.group-time .chckbx>div', (e)=>
        target = $(e.currentTarget).closest('.chckbx').data('group')
        console.log target
        schedule = Schedules.findOne({'group': target})
        @schedule = schedule.schedule
        @hours = schedule.times
        $(e.currentTarget).closest('.chckbx').addClass('_active').siblings().removeClass('_active')
        @group = target
        console.log @schedule
        @_redrawCalendar()

      $('body').on 'mouseenter', '[data-day]', (e)->
        $(e.currentTarget).find('.color-select').addClass '_hover'

      $('body').on 'mouseleave', '[data-day]', (e)->
        $(e.currentTarget).find('.color-select').removeClass '_hover'

      $('body').off 'click', '.color-select > div'

      $('body').on 'click', '.color-select > div', (e)=>
        color = $(e.currentTarget).data('color')
        $(e.currentTarget).closest('[data-day]').data('color', color)
        $(e.currentTarget).closest('[data-day]').attr('class', 'color_' + color)
        $target = $(e.currentTarget)
        content = []
        $target.closest('[data-day]').find('[contenteditable="true"]').each ->
          content.push $(this).html()
        day = $target.closest('[data-day]').data('day')
        month = $target.closest('[data-month]').data('month')
        Meteor.call 'updateSchedule', content, day, @month, @year, @group, color, (err, res)->
          if err
            console.log err
          else
            Aura.notify 'Расписание изменено!'

      $('body').on 'input', '.calendar-time-controls input', (e)=>
        Meteor.clearTimeout @saveTimesTimeout
        @saveTimesTimeout = Meteor.setTimeout =>
          val = $(e.target).val()
          index = $(e.target).closest('div').index()
          Meteor.call 'updateScheduleTimes', val, index, @group, @hours, (err, res)=>
            console.log('Times updated')
            @_refresh()
        , 1500

      $('body').on 'click', '.calendar-time-controls .remove', (e)=>
        index = $(e.target).closest('div').index()
        Meteor.call 'removeScheduleTimes', index, @group, @hours, (err, res)=>
          console.log('Time removed')
          @_refresh()

      $('body').on 'click', '.calendar-time-controls .add', (e)=>
        index = $(e.target).closest('div').index()
        Meteor.call 'addScheduleTimes', @group, @hours, (err, res)=>
          console.log('Time removed')
          @_refresh()

      $('.time-range').on 'click', (e)->
        console.log 'hey'


      $('body').off 'input', '.calendar [contenteditable="true"]'

      $('body').on 'input', '.calendar [contenteditable="true"]', (e)=>
        Meteor.clearTimeout @saveTimeout
        @saveTimeout = Meteor.setTimeout =>
          $target = $(e.currentTarget)
          content = []
          $target.closest('[data-day]').find('[contenteditable="true"]').each ->
            content.push $(this).html()
          day = $target.closest('[data-day]').data('day')
          month = $target.closest('[data-month]').data('month')
          index = $target.closest('div').index()
          color = $target.closest('[data-color]').data('color')
          Meteor.call 'updateSchedule', content, day, @month, @year, @group, color, (err, res)->
            if err
              console.log err
            else
              Aura.notify 'Расписание изменено!'
        , 1500


    _refresh: ->

      console.log('refreshing')
      schedule = Schedules.findOne({'group': @group})
      @schedule = schedule.schedule
      @hours = schedule.times
      @_redrawCalendar()


    _draw: ->

      heading = @_drawHeading()
      calendar = @_drawCalendar()
      timeControls = @_drawTimeControls()
      markup = '<div class="container"><div class="calendar" data-month="' + @month + '">' + heading + '<div class="body">' + calendar + '</div></div>' + timeControls + '</div></div></div>'
      $(@el).html(markup)
      @_showCalendar()
      @_showControls()
      if @chooseTime
        $('.group-time').addClass '_visible'


    _drawHeading: ->
      console.log @drawGroups
      controls = @_drawControls()
      markup = ''
      if @drawGroups is true
        markup += @groups
      console.log 'group is ' + @group
      if @group is 'summerSchool' or @group is 'summerSchool_evening'
        markup += @summerGroupTimes
      else if @group is 'onlineSchool_morning' or @group is 'onlineSchool_evening' or @group is 'onlineSchool_weekend'
        markup += @onlineGroupTimes
      else
        markup += @groupTimes
      markup += '<div class="container calendar-controls">'
      markup += controls
      markup += '<div class="arrows small"><button></button><button></button></div></div>'
      markup += '<div class="calendar-wrapper">'
      markup += @header
      markup

    _drawTimeControls: ->
      console.log('Roles')
      console.log(Roles)
      markup = '<div class="calendar-time-controls">'
      for i in [0..@hours.length - 1]
        markup += '<div><input class="calendar-input" value="' + @hours[i] + '"/><button class="remove">Убрать</button></div>'
      markup += '<button class="add">+ Добавить</button></div>'
      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
        markup
      else
        ''

    _redrawTimeControls: ->

      markup = ''
      for i in [0..@hours.length - 1]
        markup += '<div><input class="calendar-input" value="' + @hours[i] + '"/><button class="remove">Убрать</button></div>'
      markup += '<button class="add">+ Добавить</button>'
      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
        markup
      else
        ''
      $('.calendar-time-controls').html(markup)


    _drawCalendar: ->

      aside = @__drawAside()
      output = @__drawOutput()
      body = aside + output
      body

    _redrawCalendar: ->

      console.log 'redrawing calendar'

      newCalendar = @_drawCalendar()
      $(@el).find('.body').html(newCalendar)
      @_redrawTimeControls()

    _redrawControls: ->

      markup = '<span>' + (@year + 1900) + '</span><span>' + @months[(@month)] + '</span>'
      $(@el).find('.calendar-controls > p').html(markup)


    _drawControls: ->

      markup = '<p>'
      markup += '<span>' + (@year + 1900) + '</span>'
      markup += '<span>' + @months[@month] + '</span>'
      markup += '</p><div class="arrows small" data-year="' + @year + ' " data-month="' + @month + '"><button></button><button></button></div>'
      markup


    __drawAside: ->

      markup = '<aside>'
      for num in [1..6]
        markup += '<div>'
        for i in [0..@hours.length - 1]
          markup += '<div>' + @hours[i] + '</div>'
        markup += '</div>'
      markup += '</aside>'
      markup

    __drawOutput: ->

      furtherMonth = @month + 1
      firstDay = new Date(@year, @month , 1).getDay()
      lastDay = new Date(@year, furtherMonth, 0).getDate()
      lessonsLength = @hours.length - 1
      console.log @year
      console.log @month
      console.log firstDay
      console.log lastDay
      counter = 1
      markup = '<div class="output" data-group="' + @group + '">'
      for row in [1...7]
        markup += '<div class="calendar-row">'
        for cell in [1..7]
          markup += @__drawCell(firstDay, counter, lastDay, lessonsLength)
          counter++
        markup += '</div>'
      markup += '</div></div>'
      markup



    __drawCell: (startDay, day, lastDay, lessonsLength)->

      console.log startDay

      if day < (startDay + 2) or day > (lastDay + startDay + 1)
        markup = '<div class="_disabled"><div>'
        for num in [0..lessonsLength]
            markup += '<div><p><span></span></p></div>'
        markup += '</div></div>'
      else
        color = do =>
          if @schedule[@year] and @schedule[@year][@month] and @schedule[@year][@month][day - startDay - 1]
            @schedule[@year][@month][day - startDay - 1].color
          else
            '1'
        markup = '<div class="color_' + color + '" ' + ' data-day="' + (day - startDay - 1) + '" data-color="' + color + '"><span class="date">' + (day - startDay - 1) + '</span><section class="color-select"><div data-color="1"></div><div data-color="2"></div><div data-color="3"></div></section><div>'
        for num in [0..lessonsLength]
          if @schedule[@year] and @schedule[@year][@month]
            if @schedule[@year][@month][day - startDay - 1] and @schedule[@year][@month][day - startDay - 1]['lessons']
              markup += '<div><p><span contenteditable="true">' + @schedule[@year][@month][day - startDay - 1]['lessons'][num] + '</span></<p></p></div>'
            else
              markup += '<div><p><span contenteditable="true"> </span></p></div>'
          else
            markup += '<div><p><span contenteditable="true"> </span></p></div>'
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

    'updateSchedule': (content, day, month, year, group, color)->

      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])

        query1 = {}
        query2 = {}
        queryLessons = 'schedule.' + year + '.' + month + '.' + day + '.lessons'
        queryColor = 'schedule.' + year + '.' + month + '.' + day + '.color'
        query1[queryLessons] = content
        query2[queryColor] = color
        Schedules.update {group: group}, {$set: query1}
        Schedules.update {group: group}, {$set: query2}
        console.log query1
        console.log query2

    'updateScheduleTimes': (value, index, group, hours)->

      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
        hours[parseInt(index)] = value
        console.log(hours)
        console.log(group)
        Schedules.update {group: group}, {$set: {times: hours}}

    'removeScheduleTimes': (index, group, hours)->

      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
        hours.splice(index, 1)
        Schedules.update {group: group}, {$set: {times: hours}}

    'addScheduleTimes': (group, hours)->

      if Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])
        hours.push('00:00 - 00:00')
        Schedules.update {group: group}, {$set: {times: hours}}

  }



