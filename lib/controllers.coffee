@MainCtrl = {

  saveDB: ->

    Meteor.call 'saveCSV', (err, res)->
      if err
        console.log err
      else
        console.log res
        blob = MainCtrl.base64ToBlob(res)
        saveAs(blob, 'export.zip')

  base64ToBlob: (base64String)->
    byteCharacters = atob(base64String)
    byteNumbers    = new Array(byteCharacters.length)
    i              = 0
    while i < byteCharacters.length
      byteNumbers[i] = byteCharacters.charCodeAt(i)
      i++
    byteArray = new Uint8Array(byteNumbers)
    return blob = new Blob([byteArray],
      type: "zip"
    )

  pay: (type, amount)->

    Meteor.call 'payment', type, amount, (err, res)->
      if err
        console.log err
      else
        window.location.href = res

  sendMailing: (name, subject, bases, html)->

    console.log 'Creating mailing list'

    Meteor.call 'createMailing', name, subject, bases, html, (err, res)->

      if err

        console.log err

      else

        console.log 'Creating mailing list with ID: ' + res
        console.log 'Sending created mailing'

        Meteor.call 'sendMailing', res, (err, res)->

          if err
            console.log err
          else
            console.log res

          $('#emailModal').modal('hide')

}