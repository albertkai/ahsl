Template.mailingModal.events {

  'click #send': ->

    bases = do ->
      arr = []
      $('#mailing-bases-cont').find('input:checked').each ->
        arr.push parseInt($(this).val(), 10)
      arr

    name = $('#mailing-name').val()
    subject = $('#mailing-subject').val()
    html = Blaze.toHTML Template.email
    html += '<a id="unsub_link" href="%ОТПИСАТЬСЯ%">отписаться</a>'

    MainCtrl.sendMailing(name, subject, bases, html)

}