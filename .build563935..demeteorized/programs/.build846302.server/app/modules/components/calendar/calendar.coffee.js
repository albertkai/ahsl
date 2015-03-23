(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
if (Meteor.isClient) {
  this.Calendar = (function() {
    Calendar.prototype.group = null;

    Calendar.prototype.hourTimes = {
      children: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30'],
      teens_day: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30'],
      lateTeens: ['17:00 - 17:45', '17:55 - 18:40', '18:45 - 19:30'],
      grownUps: ['11:00 - 11:45', '11:55 - 12:35', '12:45 - 13:30', '13:40 - 14:25', '14:35 - 15:10'],
      grownUps_evening: ['19:30 - 20:15', '20:25 - 21:10', '21:15 - 22:00']
    };

    Calendar.prototype.month = new Date().getMonth();

    Calendar.prototype.year = new Date().getYear();

    Calendar.prototype.header = '<div class="header"><div>Время</div><div>ПН</div><div>ВТ</div><div>СР</div><div>ЧТ</div><div>ПТ</div><div>СБ</div><div>ВС</div></div>';

    Calendar.prototype.groups = '<div class="container group-change-cont"><div class="row"><div><button class="lead _active" data-group="children">Детская группа</button></div><div><button class="lead" data-group="teens_day">Школьная группа</button></div><div><button class="lead" data-group="lateTeens">Подростковая группа</button></div><div><button class="lead" data-group="grownUps" data-time="true">Взрослая группа</button></div></div></div>';

    Calendar.prototype.groupTimes = '<div class="container group-time"><div class="chckbx _active" data-group="grownUps"><div><div></div></div><p>Дневная группа</p></div><div class="chckbx" data-group="grownUps_evening"><div><div></div></div><p>Вечерняя группа</p></div></div>';

    Calendar.prototype.months = ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь'];

    Calendar.prototype.drawGroups = true;

    Calendar.prototype.chooseTime = false;

    Calendar.prototype.saveTimeout = null;

    function Calendar(element, options) {
      if (!element) {
        console.log('Need to provide target element to Aura::calendar');
      }
      this.el = element;
      if (options) {
        this.group = options.group;
        this.hours = this.hourTimes[this.group];
        this.month = options.month || this.month;
        this.year = options.year || this.year;
        if (options.drawGroups != null) {
          this.drawGroups = options.drawGroups;
        }
        if (options.chooseTime != null) {
          this.chooseTime = options.chooseTime;
        }
      }
      console.log(this.group);
      console.log(this.month);
      console.log(this.year);
      console.log(this.hours);
      console.log(options.drawGroups);
      this.init();
    }

    Calendar.prototype.init = function() {
      this.schedule = Schedules.findOne({
        'group': this.group
      }).schedule;
      this._draw();
      $('body').find(this.el).find('.calendar-controls .arrows').find('button:nth-child(2)').on('click', (function(_this) {
        return function(e) {
          var month;
          month = parseInt(_this.month);
          _this.month = (function() {
            if (month >= 11) {
              _this.year = _this.year + 1;
              return 0;
            } else {
              return month + 1;
            }
          })();
          console.log('month:');
          console.log(_this.month);
          _this._hideCalendar();
          _this._hideControls();
          return Meteor.setTimeout(function() {
            _this._redrawCalendar();
            _this._redrawControls();
            return Meteor.setTimeout(function() {
              _this._showCalendar();
              return _this._showControls();
            }, 100);
          }, 400);
        };
      })(this));
      $('body').find(this.el).find('.calendar-controls .arrows').find('button:nth-child(1)').on('click', (function(_this) {
        return function(e) {
          var month;
          month = parseInt(_this.month);
          _this.month = (function() {
            if (month - 1 < 0) {
              _this.year = _this.year - 1;
              return 11;
            } else {
              return month - 1;
            }
          })();
          console.log(_this.month);
          _this._hideCalendar();
          _this._hideControls();
          return Meteor.setTimeout(function() {
            _this._redrawCalendar();
            _this._redrawControls();
            return Meteor.setTimeout(function() {
              _this._showCalendar();
              return _this._showControls();
            }, 100);
          }, 400);
        };
      })(this));
      $('body').find(this.el).on('click', '.group-change-cont button', (function(_this) {
        return function(e) {
          var target;
          target = $(e.currentTarget).data('group');
          $('body').find(_this.el).find('.group-change-cont').find('button').removeClass('_active');
          $(e.currentTarget).addClass('_active');
          _this.hours = _this.hourTimes[target];
          if (!$(e.currentTarget).data('time') || $(e.currentTarget).data('time') === '') {
            $('.group-time').removeClass('_visible');
            _this.group = target;
            _this.schedule = Schedules.findOne({
              'group': target
            }).schedule;
            return _this._redrawCalendar();
          } else {
            $('.group-time').addClass('_visible');
            return $('.group-time').find('.chckbx').find('div').first().trigger('click');
          }
        };
      })(this));
      $('body').on('click', '.group-time .chckbx>div', (function(_this) {
        return function(e) {
          var target;
          target = $(e.currentTarget).closest('.chckbx').data('group');
          console.log(target);
          _this.hours = _this.hourTimes[target];
          $(e.currentTarget).closest('.chckbx').addClass('_active').siblings().removeClass('_active');
          _this.schedule = Schedules.findOne({
            'group': target
          }).schedule;
          _this.group = target;
          console.log(_this.schedule);
          return _this._redrawCalendar();
        };
      })(this));
      $('body').on('mouseenter', '[data-day]', function(e) {
        return $(e.currentTarget).find('.color-select').addClass('_hover');
      });
      $('body').on('mouseleave', '[data-day]', function(e) {
        return $(e.currentTarget).find('.color-select').removeClass('_hover');
      });
      $('body').off('click', '.color-select > div');
      $('body').on('click', '.color-select > div', (function(_this) {
        return function(e) {
          var $target, color, content, day, month;
          color = $(e.currentTarget).data('color');
          $(e.currentTarget).closest('[data-day]').data('color', color);
          $(e.currentTarget).closest('[data-day]').attr('class', 'color_' + color);
          $target = $(e.currentTarget);
          content = [];
          $target.closest('[data-day]').find('[contenteditable="true"]').each(function() {
            return content.push($(this).html());
          });
          day = $target.closest('[data-day]').data('day');
          month = $target.closest('[data-month]').data('month');
          return Meteor.call('updateSchedule', content, day, _this.month, _this.year, _this.group, color, function(err, res) {
            if (err) {
              return console.log(err);
            } else {
              return Aura.notify('Расписание изменено!');
            }
          });
        };
      })(this));
      $('body').off('input', '.calendar [contenteditable="true"]');
      return $('body').on('input', '.calendar [contenteditable="true"]', (function(_this) {
        return function(e) {
          Meteor.clearTimeout(_this.saveTimeout);
          return _this.saveTimeout = Meteor.setTimeout(function() {
            var $target, color, content, day, index, month;
            $target = $(e.currentTarget);
            content = [];
            $target.closest('[data-day]').find('[contenteditable="true"]').each(function() {
              return content.push($(this).html());
            });
            day = $target.closest('[data-day]').data('day');
            month = $target.closest('[data-month]').data('month');
            index = $target.closest('div').index();
            color = $target.closest('[data-color]').data('color');
            return Meteor.call('updateSchedule', content, day, _this.month, _this.year, _this.group, color, function(err, res) {
              if (err) {
                return console.log(err);
              } else {
                return Aura.notify('Расписание изменено!');
              }
            });
          }, 1500);
        };
      })(this));
    };

    Calendar.prototype._draw = function() {
      var calendar, heading, markup;
      heading = this._drawHeading();
      calendar = this._drawCalendar();
      markup = '<div class="container"><div class="calendar" data-month="' + this.month + '">' + heading + '<div class="body">' + calendar + '</div></div></div>';
      $(this.el).html(markup);
      this._showCalendar();
      this._showControls();
      if (this.chooseTime) {
        return $('.group-time').addClass('_visible');
      }
    };

    Calendar.prototype._drawHeading = function() {
      var controls, markup;
      console.log(this.drawGroups);
      controls = this._drawControls();
      markup = '';
      if (this.drawGroups === true) {
        markup += this.groups;
      }
      markup += this.groupTimes;
      markup += '<div class="container calendar-controls">';
      markup += controls;
      markup += '<div class="arrows small"><button></button><button></button></div></div>';
      markup += this.header;
      return markup;
    };

    Calendar.prototype._drawCalendar = function() {
      var aside, body, output;
      aside = this.__drawAside();
      output = this.__drawOutput();
      body = aside + output;
      return body;
    };

    Calendar.prototype._redrawCalendar = function() {
      var newCalendar;
      console.log('redrawing calendar');
      newCalendar = this._drawCalendar();
      return $(this.el).find('.body').html(newCalendar);
    };

    Calendar.prototype._redrawControls = function() {
      var markup;
      markup = '<span>' + (this.year + 1900) + '</span><span>' + this.months[this.month] + '</span>';
      return $(this.el).find('.calendar-controls > p').html(markup);
    };

    Calendar.prototype._drawControls = function() {
      var markup;
      markup = '<p>';
      markup += '<span>' + (this.year + 1900) + '</span>';
      markup += '<span>' + this.months[this.month] + '</span>';
      markup += '</p><div class="arrows small" data-year="' + this.year + ' " data-month="' + this.month + '"><button></button><button></button></div>';
      return markup;
    };

    Calendar.prototype.__drawAside = function() {
      var i, markup, num, _i, _j, _ref;
      markup = '<aside>';
      for (num = _i = 1; _i <= 6; num = ++_i) {
        markup += '<div>';
        for (i = _j = 0, _ref = this.hours.length - 1; 0 <= _ref ? _j <= _ref : _j >= _ref; i = 0 <= _ref ? ++_j : --_j) {
          markup += '<div>' + this.hours[i] + '</div>';
        }
        markup += '</div>';
      }
      markup += '</aside>';
      return markup;
    };

    Calendar.prototype.__drawOutput = function() {
      var cell, counter, firstDay, furtherMonth, lastDay, lessonsLength, markup, row, _i, _j;
      furtherMonth = this.month + 1;
      firstDay = new Date(this.year, this.month, 1).getDay();
      lastDay = new Date(this.year, furtherMonth, 0).getDate();
      lessonsLength = this.hours.length - 1;
      console.log(this.year);
      console.log(this.month);
      console.log(firstDay);
      console.log(lastDay);
      counter = 1;
      markup = '<div class="output" data-group="' + this.group + '">';
      for (row = _i = 1; _i < 7; row = ++_i) {
        markup += '<div class="calendar-row">';
        for (cell = _j = 1; _j <= 7; cell = ++_j) {
          markup += this.__drawCell(firstDay, counter, lastDay, lessonsLength);
          counter++;
        }
        markup += '</div>';
      }
      markup += '</div></div>';
      return markup;
    };

    Calendar.prototype.__drawCell = function(startDay, day, lastDay, lessonsLength) {
      var color, markup, num, _i, _j;
      console.log(startDay);
      if (day < (startDay + 2) || day > (lastDay + startDay + 1)) {
        markup = '<div class="_disabled"><div>';
        for (num = _i = 0; 0 <= lessonsLength ? _i <= lessonsLength : _i >= lessonsLength; num = 0 <= lessonsLength ? ++_i : --_i) {
          markup += '<div><p><span></span></p></div>';
        }
        return markup += '</div></div>';
      } else {
        color = (function(_this) {
          return function() {
            if (_this.schedule[_this.year] && _this.schedule[_this.year][_this.month] && _this.schedule[_this.year][_this.month][day - startDay - 1]) {
              return _this.schedule[_this.year][_this.month][day - startDay - 1].color;
            } else {
              return '1';
            }
          };
        })(this)();
        markup = '<div class="color_' + color + '" ' + ' data-day="' + (day - startDay - 1) + '" data-color="' + color + '"><span class="date">' + (day - startDay - 1) + '</span><section class="color-select"><div data-color="1"></div><div data-color="2"></div><div data-color="3"></div></section><div>';
        for (num = _j = 0; 0 <= lessonsLength ? _j <= lessonsLength : _j >= lessonsLength; num = 0 <= lessonsLength ? ++_j : --_j) {
          if (this.schedule[this.year] && this.schedule[this.year][this.month]) {
            if (this.schedule[this.year][this.month][day - startDay - 1] && this.schedule[this.year][this.month][day - startDay - 1]['lessons']) {
              markup += '<div><p><span contenteditable="true">' + this.schedule[this.year][this.month][day - startDay - 1]['lessons'][num] + '</span></<p></p></div>';
            } else {
              markup += '<div><p><span contenteditable="true"> </span></p></div>';
            }
          } else {
            markup += '<div><p><span contenteditable="true"> </span></p></div>';
          }
        }
        markup += '</div></div>';
        return markup;
      }
    };

    Calendar.prototype._showCalendar = function() {
      return $(this.el).find('.body').addClass('_visible');
    };

    Calendar.prototype._showControls = function() {
      return $(this.el).find('.calendar-controls').addClass('_visible');
    };

    Calendar.prototype._hideCalendar = function() {
      return $(this.el).find('.body').removeClass('_visible');
    };

    Calendar.prototype._hideControls = function() {
      return $(this.el).find('.calendar-controls').removeClass('_visible');
    };

    Calendar.prototype._setMonth = function(month) {
      return this.month = month;
    };

    Calendar.prototype._setYear = function(year) {
      return this.year = year;
    };

    Calendar.prototype._setGroup = function(group) {
      return this.group = group;
    };

    return Calendar;

  })();
}

if (Meteor.isServer) {
  Meteor.methods({
    'updateSchedule': function(content, day, month, year, group, color) {
      var query1, query2, queryColor, queryLessons;
      if (Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])) {
        query1 = {};
        query2 = {};
        queryLessons = 'schedule.' + year + '.' + month + '.' + day + '.lessons';
        queryColor = 'schedule.' + year + '.' + month + '.' + day + '.color';
        query1[queryLessons] = content;
        query2[queryColor] = color;
        Schedules.update({
          group: group
        }, {
          $set: query1
        });
        Schedules.update({
          group: group
        }, {
          $set: query2
        });
        console.log(query1);
        return console.log(query2);
      }
    }
  });
}

})();

//# sourceMappingURL=calendar.coffee.js.map
