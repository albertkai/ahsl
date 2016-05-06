console.log 'Aura server initialized'

Meteor.publish 'auraPages', ->
  AuraPages.find()

Meteor.publish 'users', ->
  Meteor.users.find()

#Meteor.publish 'auraHistory', ->
#  AuraHistory.find({}, {limit: 50})

Meteor.publish 'auraLogs', ->
  AuraLogs.find()

Meteor.publish 'auraSettings', ->
  AuraSettings.find()

if Meteor.isServer
  Meteor.startup ->
    @Future = Npm.require('fibers/future')
    @fs = Npm.require('fs')
    @AWS = Npm.require('aws-sdk')
    @dataUriToBuffer = Npm.require('data-uri-to-buffer')
    AWS.config.update
      accessKeyId: process.env.AWS_KEY_ID
      secretAccessKey: process.env.AWS_SECRET
    AWS.config.region = 'eu-west-1'



if Meteor.isServer

  Meteor.methods {

    uploadPic: (pic, bucket)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])

        s3 = new AWS.S3()

        buffer = new Buffer(pic.data, 'binary')

        newName = do ->
          extention = _.last pic.name.split('.')
          randomName = Random.id()
          randomName + '.' + extention

        origImage =  {
          Key: newName
          ContentType: pic.type
          Body: buffer
          Bucket: bucket
        }

        f = new Future()

        s3.putObject origImage, (err, data)->
          if err
            console.log err
            f.return(false)
          else
            console.log 'object ' + pic.name + ' with new name ' + newName + ' uploaded to S3! Congrats!'
            f.return(newName)

        f.wait()

    uploadWithThumb: (pics, bucket)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])

        s3 = new AWS.S3()

        origBuffer = new Buffer(pics[0].data, 'binary')
        resizedBuffer = dataUriToBuffer(pics[1].data)

        console.log pics
        console.log pics[0].fileInfo
        console.log pics[0].fileInfo.name

        newName = do ->
          extention = _.last pics[0].fileInfo.name.split('.')
          randomName = Random.id()
          {
          orig: randomName + '.' + extention
          thumb: randomName + '_thumb.' + extention
          }


        origImage =  {
          Key: newName.orig
          ContentType: pics[0].fileInfo.type
          Body: origBuffer
          Bucket: bucket
        }

        resizedImage =  {
          Key: newName.thumb
          ContentType: pics[0].fileInfo.type
          Body: resizedBuffer
          Bucket: bucket
        }

        f = new Future()

        s3.putObject origImage, (err, data)->
          if err
            console.log err
            f.return(false)
          else
            console.log 'object ' + pics[0].fileInfo.name + ' named ' + newName.orig + ' uploaded to S3! Congrats!'
            f.return(true)

        f.wait()

        f = new Future()

        s3.putObject resizedImage, (err, data)->
          if err
            console.log err
            f.return(false)
          else
            console.log 'object ' + pics[1].fileInfo.name + ' thumb named ' + newName.thumb + ' uploaded to S3'
            f.return(true)

        f.wait()

        newName.orig

    deletePic: (pic, bucket)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])

        s3 = new AWS.S3()

        params = {
          Bucket: bucket
          Key: pic
        }

        f = new Future()

        s3.deleteObject params, (err, data)->
          if (err)
            console.log(err, err.stack)
            f.return(false)
          else
            console.log data
            console.log('object ' + pic + ' deleted from S3')
            f.return(true)

        f.wait()


    deletePics: (pics, bucket)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])

        if pics.length > 0

          s3 = new AWS.S3()

          params = {
            Bucket: bucket,
            Delete: {
              Objects: []
            }
          }

          pics.forEach (pic)->
            obj = {}
            obj['Key'] = pic
            params.Delete.Objects.push obj

          f = new Future()

          s3.deleteObjects params, (err, data)->
            if (err)
              console.log(err, err.stack)
              f.return(false)
            else
              console.log('object ' + pics + ' deleted from S3')
              f.return(true)

          f.wait()

        else

          console.log 'no pics to delete'

          true


    auraCreateUser: (options)->

      console.log 'creating new user'

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner'])
        user = Accounts.createUser {
          username: options.name
          email: options.email
          password: options.password
          profile: {
            name: options.name,
            surname: options.surname,
            pic: options.pic if options.pic?
          }
        }

        Roles.addUsersToRoles(user, options.role)

        user
      else
        'Permission denied'



    auraRemoveUser: (id)->

      loggedInUser = Meteor.user()
      userToDelete = Meteor.users.findOne({_id: id})
      if Roles.userIsInRole(loggedInUser, ['owner'])
        if !Roles.userIsInRole(userToDelete, ['owner'])
          Meteor.users.remove {'_id': id}
        else
          Aura.notify 'Нельзя удалить владельца сайта, обратитесь для этого к разработчику'


    saveHtml: (item)->
      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        query = {}
        searchQuery = {}
        query[item.field] = item.data
        searchQuery[item.index] = item.document
        console.log item
        console.log searchQuery
        console.log query
        AuraColl[item.collection].update searchQuery, {$set: query}

        Meteor.call 'saveHistory', item
#        Meteor.call 'saveLogs', item

#        AuraLogs.insert {
#          userId:
#          name:
#        }

    saveHistory: (item)->
      loggedInUser = Meteor.user()
      console.log 'History item:'
      historyItem = item
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        historyItem['userId'] = loggedInUser._id
        historyItem['name'] = loggedInUser.profile.name
        historyItem['surname'] = loggedInUser.profile.surname
        historyItem['date'] = Date.parse(new Date())
        historyItem['restored'] = false
        console.log historyItem
        AuraHistory.insert historyItem

    restoreHistory: (id)->

      loggedInUser = Meteor.user()
      item = AuraHistory.findOne({_id: id})
      console.log 'Restoring history item:'
      console.log item
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        query = {}
        searchQuery = {}
        searchQuery[item.index] = item.document
        query[item.field] = do ->
          if !item.restored
            item.changedData
          else
            item.data
        AuraColl[item.collection].update searchQuery, {$set: query}
        AuraHistory.update {_id: id}, {$set: {restored: !item.restored}}
        query[item.field]



    addListItem: (document, field, object)->
      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        query = {}
        query[field] = object
        console.log query
        AuraPages.update {'name': document}, {$push: query}

    removeListItem: (document, field, object)->
      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        query = {}
        query[field] = object
        AuraPages.update {'name': document}, {$pull: query}

  }