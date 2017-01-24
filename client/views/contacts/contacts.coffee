

Template.contacts.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  $('#contacts-user-phone').inputmask("+7(999)999-99-99")

  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "http://maps.google.com/maps/api/js?sensor=false&libraries=places&callback=initializeMap"
  script.id = "googleMaps"
  if $('#googleMaps').length > 0
    initializeMap()
  else
    document.body.appendChild(script)

  Meteor.subscribe 'voted'


Template.contacts.events {

  'click button.lead': ->

    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#contacts-user-name').val() isnt '' and $('#contacts-user-phone').val() isnt '' and re.test($('#contacts-user-email').val())

      if $('#contacts-user-name').val() is ''
        $('#contacts-user-name').addClass '_invalid'
      else
        $('#contacts-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#contacts-user-email').val())
        $('#contacts-user-email').addClass '_invalid'
      else
        $('#contacts-user-email').removeClass('_invalid').addClass '_valid'
      if $('#contacts-user-phone').val() is ''
        $('#contacts-user-phone').addClass '_invalid'
      else
        $('#contacts-user-phone').removeClass('_invalid').addClass '_valid'
      title = 'Заявка а обучение - общее'
      name = $('#contacts-user-name').val()
      phone = $('#contacts-user-phone').val()
      email = $('#contacts-user-email').val()

      NProgress.start()
      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              NProgress.done()
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#contacts-user-name').val() is ''
        $('#contacts-user-name').addClass '_invalid'
      else
        $('#contacts-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#contacts-user-email').val())
        $('#contacts-user-email').addClass '_invalid'
      else
        $('#contacts-user-email').removeClass('_invalid').addClass '_valid'
      if $('#contacts-user-phone').val() is ''
        $('#contacts-user-phone').addClass '_invalid'
      else
        $('#contacts-user-phone').removeClass('_invalid').addClass '_valid'

}


@initializeMap = ->

#  myLatLng = new google.maps.LatLng(59.940577, 30.378407)
#  myLatLng2 = new google.maps.LatLng(59.9451941, 30.3671845)
#
#  mapOptions = {
#    center: myLatLng,
#    zoom:13,
#    zoomControl:true,
#    zoomControlOpt:{
#      style:"MEDIUM",
#      position:"RIGHT_BOTTOM"
#    },
#    panControl:true,
#    streetViewControl:false,
#    mapTypeControl:false,
#    overviewMapControl:false,
#    scrollwheel:false
#  }
#
#
#  map  = new google.maps.Map(document.getElementById('map'), mapOptions)
#  google.maps.event.addListener map, 'tilesloaded', ->
#    $('#map').addClass '_loaded'
#    $('.loading-map').css 'display', 'none'
#
#
#  styles = [
#    {
#      "stylers": [
#        { "saturation": -100 },
#        { "weight": 1.3 }
#      ]
#    },{
#      "featureType": "water",
#      "stylers": [
#        { "lightness": 100 }
#      ]
#    },{
#      "featureType": "administrative",
#      "stylers": [
#        { "lightness": -69 }
#      ]
#    },{
#      "featureType": "landscape",
#      "stylers": [
#        { "lightness": 23 }
#      ]
#    },{
#      "featureType": "poi",
#      "stylers": [
#        { "lightness": -8 }
#      ]
#    },{
#      "featureType": "transit",
#      "stylers": [
#        { "lightness": -5 }
#      ]
#    },{
#      "featureType": "road",
#      "elementType": "geometry",
#      "stylers": [
#        { "lightness": 100 }
#      ]
#    }
#  ]
#
#  styledMap = new google.maps.StyledMapType(styles, {name: "Styled Map"})
#
#  map.mapTypes.set('map_style', styledMap)
#
#  map.setMapTypeId('map_style')
#
#  image = '/img/marker.png'
#
#  marker = new google.maps.Marker({
#    position: myLatLng,
#    map: map,
#    icon: image
#  })
#
#  marker2 = new google.maps.Marker({
#    position: myLatLng2,
#    map: map,
#    icon: image
#  })