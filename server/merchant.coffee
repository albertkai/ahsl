Meteor.methods {

  'payment': (method, requestId, amount)->

    if method is 'card'

      PayOnline = Meteor.npmRequire('payonline')

      f = new Future()

      payOnlineClient = new PayOnline {
        merchantId: "66888",
        privateSecurityKey: process.env.PRIVATE_SECURITY_KEY
      }

      params = {
        "OrderId": requestId,
        "Amount": amount,
        "Currency": "RUB",
        "returnUrl": 'http://ladies-school.com/success'
#        "orderDescription": requestId
      }

      payOnlineClient.getPaymentUrl params, (err, url)->
        if err
          console.log err
          f.return(err)
        else
          console.log("Payment url: " + url)
          f.return(url)

      f.wait()




}