console.log 'Aura server initialized'

Meteor.publish 'auraPages', ->
  AuraPages.find()

Meteor.publish 'users', ->
  Meteor.users.find()

if Meteor.isServer
  Meteor.startup ->
    @Future = Npm.require('fibers/future')
    @fs = Npm.require('fs')
    @AWS = Npm.require('aws-sdk')
    process.env.MAIL_URL = 'smtp://postmaster@sandbox32926.mailgun.org:5ty-i8q8jz-3@smtp.mailgun.org:587'
    AWS.config.update
      accessKeyId: 'AKIAJKHELBJSF7V6D7FQ'
      secretAccessKey: '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'
#    AWS.config.loadFromPath('config.json')
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

    uploadWithThumb: (pics)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])

        s3 = new AWS.S3()

        origBuffer = new Buffer(pics[0].data, 'binary')

        resizedBuffer = new Buffer(pics[1].data, 'binary')

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
          Bucket: 'ahsl/aura'
        }

        resizedImage =  {
          Key: newName.thumb
          ContentType: pics[0].fileInfo.type
          Body: resizedBuffer
          Bucket: 'ahsl/aura'
        }

        f = new Future()

        s3.putObject origImage, (err, data)->
          if err
            console.log err
            f.return(false)
          else
            console.log 'object ' + pics[0].fileInfo.name + 'named ' + newName.orig + ' uploaded to S3! Congrats!'
            f.return(true)

        f.wait()

        f = new Future()

        s3.putObject resizedImage, (err, data)->
          if err
            console.log err
            f.return(false)
          else
            console.log 'object ' + pics[1].fileInfo.name + ' thumb named' + newName.thumb + 'uploaded to S3'
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
            console.log('object ' + pic + ' deleted from S3')
            f.return(true)

        f.wait()


    deletePics: (pics)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])

        if pics.length > 0

          s3 = new AWS.S3()

          params = {
            Bucket: 'ahsl/aura',
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

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner'])
        user = Accounts.createUser {
          username: options.name
          email: options.email
          password: options.password
          profile: {
            name: options.name,
            surname: options.surname,
          }
        }

        Roles.addUsersToRoles(user, options.role)

        user
      else
        'Permission denied'

    auraRemoveUser: (id)->

      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner'])
        Meteor.users.remove {'_id': id}


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

    addListItem: (document, field, object)->
      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        query = {}
        query[field] = object
        AuraPages.update {'name': document}, {$push: query}

    removeListItem: (document, field, object)->
      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        query = {}
        query[field] = object
        AuraPages.update {'name': document}, {$pull: query}

    saveHistory: (item)->
      loggedInUser = Meteor.user()
      if Roles.userIsInRole(loggedInUser, ['owner', 'admin'])
        AuraHistory.insert item

  }