@Schedules = new Meteor.Collection('schedules')

#groups: children, teens, lateteens, grownups


Schedules.allow {

  insert: ->
    true

  update: ->
    true

}

if Meteor.isServer

  Schedules.find().fetch().forEach (s)->
    Schedules.remove {'_id': s._id}

  if Schedules.find().count() is 0

    Schedules.insert {

      group: 'lateTeens'

      schedule: {

        11: {
          1: ['верховая езда', 'верховая езда', 'верховая езда']
          2: ['верховая езда', 'верховая езда', 'верховая езда']
          8: ['верховая езда', 'верховая езда', 'верховая езда']
          9: ['верховая езда', 'верховая езда', 'верховая езда']
          10: ['', 'этикет', 'стилистика']
          11: ['этикет', 'имиджеология', 'имиджеология']
          13: ['актерское мастерство', 'актерское мастерство', 'стилистика']
          14: ['имиджеология', 'английский', 'английский']
          15: ['верховая езда', 'верховая езда', 'верховая езда']
          16: ['верховая езда', 'верховая езда', 'верховая езда']
          17: ['', 'стилистика (выезд)', 'стилистика (выезд)']
          18: ['этикет', 'имиджеология', 'имиджеология']
          20: ['актерское мастерство', 'актерское мастерство', 'стилистика']
          21: ['имиджеология', 'английский', 'английский']
          22: ['верховая езда', 'верховая езда', 'верховая езда']
          23: ['верховая езда', 'верховая езда', 'верховая езда']
          24: ['', 'этикет', 'стилистика']
          25: ['этикет', 'имиджеология', 'имиджеология']
          27: ['актерское мастерство', 'актерское мастерство', 'стилистика']
          29: ['верховая езда', 'верховая езда', 'верховая езда']
          30: ['верховая езда', 'верховая езда', 'верховая езда']
        }

      }

    }

    Schedules.insert {

      group: 'children'

      schedule: {

        11: {
          11: ['имиджеология', 'имиджеология', 'этикет']
          12: ['английский', 'английский', 'этикет']
          13: ['стилистика', 'стилистика', 'актерское мастерство']
          18: ['имиджеология', 'имиджеология', 'этикет']
          19: ['английский', 'английский', 'этикет']
          20: ['стилистика', 'стилистика', 'актерское мастерство']
          25: ['имиджеология', 'имиджеология', 'этикет']
          26: ['английский', 'английский', 'этикет']
          27: ['стилистика', 'стилистика', 'актерское мастерство']
        }

      }

    }

    Schedules.insert {

      group: 'teens_day'

      schedule: {

        11: {
          1: ['верховая езда', 'верховая езда', 'верховая езда']
          2: ['верховая езда', 'верховая езда', 'верховая езда']
          8: ['верховая езда', 'верховая езда', 'верховая езда']
          9: ['верховая езда', 'верховая езда', 'верховая езда']
          10: ['стилистика', 'стилистика', 'этикет']
          12: ['этикет', 'этикет', 'имиджеология']
          15: ['верховая езда', 'верховая езда', 'верховая езда']
          16: ['верховая езда', 'верховая езда', 'верховая езда']
          17: ['этикет', 'этикет', 'актерское мастерство']
          19: ['стилистика', 'стилистика', 'имиджеология']
          21: ['английский', 'имиджеология', '']
          22: ['верховая езда', 'верховая езда', 'верховая езда']
          23: ['верховая езда', 'верховая езда', 'верховая езда']
          24: ['стилистика', 'стилистика', 'актерское мастерство']
          26: ['этикет', 'этикет', 'имиджеология']
          28: ['английский', 'имиджеология', '']
          29: ['верховая езда', 'верховая езда', 'верховая езда']
          30: ['верховая езда', 'верховая езда', 'верховая езда']
        }

      }

    }

    Schedules.insert {

      group: 'grownUps'

      schedule: {

        11: {
          1: ['верховая езда', 'верховая езда', 'верховая езда']
          2: ['верховая езда', 'верховая езда', 'верховая езда']
          8: ['верховая езда', 'верховая езда', 'верховая езда']
          9: ['верховая езда', 'верховая езда', 'верховая езда']
          10: ['стилистика', 'стилистика', 'этикет']
          12: ['этикет', 'этикет', 'имиджеология']
          15: ['верховая езда', 'верховая езда', 'верховая езда']
          16: ['верховая езда', 'верховая езда', 'верховая езда']
          17: ['этикет', 'этикет', 'актерское мастерство']
          19: ['стилистика', 'стилистика', 'имиджеология']
          21: ['английский', 'имиджеология', '']
          22: ['верховая езда', 'верховая езда', 'верховая езда']
          23: ['верховая езда', 'верховая езда', 'верховая езда']
          24: ['стилистика', 'стилистика', 'актерское мастерство']
          26: ['этикет', 'этикет', 'имиджеология']
          28: ['английский', 'имиджеология', '']
          29: ['верховая езда', 'верховая езда', 'верховая езда']
          30: ['верховая езда', 'верховая езда', 'верховая езда']
        }

      }

    }