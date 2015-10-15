@Schedules = new Meteor.Collection('schedules')

#groups: children, teens, lateteens, grownups


Schedules.allow {

  insert: (userId)->
    if userId
      true

  update: (userId)->
    if userId
      true

}


#if Meteor.isServer
#
#  Schedules.find().fetch().forEach (s)->
#    Schedules.remove {'_id': s._id}
#
#
#
#
#  if Schedules.find().count() is 0
#
#    Schedules.insert {
#
#      group: 'lateTeens'
#
#      schedule: {
#
#        114: {
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            2: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            8: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            9: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            10: {
#              lessons: ['', 'этикет', 'стилистика']
#              color: '1'
#            }
#            11: {
#              lessons: ['этикет', 'имиджеология', 'имиджеология']
#              color: '2'
#            }
#            13: {
#              lessons: ['актерское мастерство', 'актерское мастерство', 'стилистика']
#              color: '1'
#            }
#            14: {
#              lessons: ['имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            15: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            16: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            17: {
#              lessons: ['', 'стилистика (выезд)', 'стилистика (выезд)']
#              color: '1'
#            }
#            18: {
#              lessons: ['этикет', 'имиджеология', 'имиджеология']
#              color: '1'
#            }
#            20: {
#              lessons: ['актерское мастерство', 'актерское мастерство', 'стилистика']
#              color: '1'
#            }
#            21: {
#              lessons: ['имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            22: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            23: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            24: {
#              lessons: ['', 'этикет', 'стилистика']
#              color: '1'
#            }
#            25: {
#              lessons: ['этикет', 'имиджеология', 'имиджеология']
#              color: '1'
#            }
#            27: {
#              lessons: ['актерское мастерство', 'актерское мастерство', 'стилистика']
#              color: '1'
#            }
#            29: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            30: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#    Schedules.insert {
#
#      group: 'children'
#
#      schedule: {
#
#        114: {
#          10: {
#            11: {
#              lessons: ['имиджеология', 'имиджеология', 'этикет']
#              color: '1'
#            }
#            12: {
#              lessons: ['английский', 'английский', 'этикет']
#              color: '1'
#            }
#            13: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство']
#              color: '1'
#            }
#            18: {
#              lessons: ['имиджеология', 'имиджеология', 'этикет']
#              color: '1'
#            }
#            19: {
#              lessons: ['английский', 'английский', 'этикет']
#              color: '1'
#            }
#            20: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство']
#              color: '1'
#            }
#            25: {
#              lessons: ['имиджеология', 'имиджеология', 'этикет']
#              color: '1'
#            }
#            26: {
#              lessons: ['английский', 'английский', 'этикет']
#              color: '1'
#            }
#            27: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#    Schedules.insert {
#
#      group: 'teens_day'
#
#      schedule: {
#
#        114: {
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            2: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            8: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            9: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            10: {
#              lessons: ['стилистика', 'стилистика', 'этикет']
#              color: '1'
#            }
#            12: {
#              lessons: ['этикет', 'этикет', 'имиджеология']
#              color: '1'
#            }
#            15: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            16: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            17: {
#              lessons: ['этикет', 'этикет', 'актерское мастерство']
#              color: '2'
#            }
#            19: {
#              lessons: ['стилистика', 'стилистика', 'имиджеология']
#              color: '1'
#            }
#            21: {
#              lessons: ['английский', 'имиджеология', '']
#              color: '1'
#            }
#            22: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            23: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            24: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство']
#              color: '1'
#            }
#            26: {
#              lessons: ['этикет', 'этикет', 'имиджеология']
#              color: '1'
#            }
#            28: {
#              lessons: ['английский', 'имиджеология', '']
#              color: '1'
#            }
#            29: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            30: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#  if Schedules.find({group: 'grownUps_evening'}).count() is 0
#
#    Schedules.insert {
#
#      group: 'grownUps_evening'
#
#      schedule: {
#
#        114: {
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            2: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            8: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            9: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            10: {
#              lessons: ['стилистика', 'стилистика', 'этикет']
#              color: '1'
#            }
#            12: {
#              lessons: ['этикет', 'этикет', 'имиджеология']
#              color: '1'
#            }
#            15: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            16: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            17: {
#              lessons: ['этикет', 'этикет', 'актерское мастерство']
#              color: '1'
#            }
#            19: {
#              lessons: ['стилистика', 'стилистика', 'имиджеология']
#              color: '1'
#            }
#            21: {
#              lessons: ['английский', 'имиджеология', '']
#              color: '1'
#            }
#            22: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            23: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            24: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство']
#              color: '1'
#            }
#            26: {
#              lessons: ['этикет', 'этикет', 'имиджеология']
#              color: '1'
#            }
#            28: {
#              lessons: ['английский', 'имиджеология', '']
#              color: '1'
#            }
#            29: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#            30: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#
#  if Schedules.findOne({group: 'grownUps'})
#    Schedules.remove {'_id': Schedules.findOne({group: 'grownUps'})._id}
#
#    Schedules.insert {
#
#      group: 'grownUps'
#
#      schedule: {
#
#        114: {
#
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            2: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            8: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            9: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            10: {
#              lessons: ['стилистика', 'стилистика', 'этикет', 'английский', 'английский']
#              color: '1'
#            }
#            12: {
#              lessons: ['этикет', 'этикет', 'имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            15: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            16: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            17: {
#              lessons: ['этикет', 'этикет', 'актерское мастерство', 'английский', 'английский']
#              color: '1'
#            }
#            19: {
#              lessons: ['стилистика', 'стилистика', 'имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            21: {
#              lessons: ['английский', 'имиджеология', '', 'английский', 'английский']
#              color: '1'
#            }
#            22: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            23: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            24: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство', 'английский', 'английский']
#              color: '1'
#            }
#            26: {
#              lessons: ['этикет', 'этикет', 'имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            28: {
#              lessons: ['английский', 'имиджеология', '', 'английский', 'английский']
#              color: '1'
#            }
#            29: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            30: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#          }
#
#        }
#
#      }
#
#    }
#  if Schedules.find({group: 'summerSchool_evening'}).count() is 0
#
#    Schedules.insert {
#
#      group: 'summerSchool_evening'
#
#      schedule: {
#
#        115: {
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#  if Schedules.find({group: 'onlineSchool'}).count() is 0
#
#    Schedules.insert {
#
#      group: 'onlineSchool'
#
#      schedule: {
#
#        115: {
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#  if Schedules.find({group: 'summerSchool'}).count() is 0
#
#    Schedules.insert {
#
#      group: 'summerSchool'
#
#      schedule: {
#
#        115: {
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда']
#              color: '1'
#            }
#          }
#        }
#
#      }
#
#    }
#
#
#  if Schedules.findOne({group: 'grownUps'})
#    Schedules.remove {'_id': Schedules.findOne({group: 'grownUps'})._id}
#
#    Schedules.insert {
#
#      group: 'grownUps'
#
#      schedule: {
#
#        114: {
#
#          10: {
#            1: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            2: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            8: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            9: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            10: {
#              lessons: ['стилистика', 'стилистика', 'этикет', 'английский', 'английский']
#              color: '1'
#            }
#            12: {
#              lessons: ['этикет', 'этикет', 'имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            15: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            16: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            17: {
#              lessons: ['этикет', 'этикет', 'актерское мастерство', 'английский', 'английский']
#              color: '1'
#            }
#            19: {
#              lessons: ['стилистика', 'стилистика', 'имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            21: {
#              lessons: ['английский', 'имиджеология', '', 'английский', 'английский']
#              color: '1'
#            }
#            22: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            23: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            24: {
#              lessons: ['стилистика', 'стилистика', 'актерское мастерство', 'английский', 'английский']
#              color: '1'
#            }
#            26: {
#              lessons: ['этикет', 'этикет', 'имиджеология', 'английский', 'английский']
#              color: '1'
#            }
#            28: {
#              lessons: ['английский', 'имиджеология', '', 'английский', 'английский']
#              color: '1'
#            }
#            29: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#            30: {
#              lessons: ['верховая езда', 'верховая езда', 'верховая езда', 'английский', 'английский']
#              color: '1'
#            }
#          }
#
#        }
#
#      }
#
#    }
