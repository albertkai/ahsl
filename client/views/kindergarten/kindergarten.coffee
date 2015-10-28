Template.kindergarten.onRendered ->

  console.log 'Kindergarten rendered!'

  Meteor.defer ->
    $('.wrap').addClass '_animated'
    $('body').stellar()

  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "http://maps.google.com/maps/api/js?sensor=false&libraries=places&callback=initializeMap2"
  script.id = "googleMaps"
  if $('#googleMaps').length > 0
    initializeMap()
  else
    document.body.appendChild(script)



@initializeMap2 = ->

  myLatLng = new google.maps.LatLng(59.940577, 30.378407)

  mapOptions = {
    center: myLatLng,
    zoom:13,
    zoomControl:true,
    zoomControlOpt:{
      style:"MEDIUM",
      position:"RIGHT_BOTTOM"
    },
    panControl:true,
    streetViewControl:false,
    mapTypeControl:false,
    overviewMapControl:false,
    scrollwheel:false
  }


  map  = new google.maps.Map(document.getElementById('map'), mapOptions)
  google.maps.event.addListener map, 'tilesloaded', ->
    $('#map').addClass '_loaded'
    $('.loading-map').css 'display', 'none'

  styles = [
    {
      "stylers": [
        { "saturation": -100 },
        { "weight": 1.3 }
      ]
    },{
      "featureType": "water",
      "stylers": [
        { "lightness": 100 }
      ]
    },{
      "featureType": "administrative",
      "stylers": [
        { "lightness": -69 }
      ]
    },{
      "featureType": "landscape",
      "stylers": [
        { "lightness": 23 }
      ]
    },{
      "featureType": "poi",
      "stylers": [
        { "lightness": -8 }
      ]
    },{
      "featureType": "transit",
      "stylers": [
        { "lightness": -5 }
      ]
    },{
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        { "lightness": 100 }
      ]
    }
  ]

  styledMap = new google.maps.StyledMapType(styles, {name: "Styled Map"})

  map.mapTypes.set('map_style', styledMap)

  map.setMapTypeId('map_style')

  image = '/img/marker.png'

  marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    icon: image
  })


Template.kindergarten.events


  'click .send-request': (e)->

    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#direction-user-name').val() isnt '' and $('#direction-user-phone').val() isnt '' and re.test($('#direction-user-email').val())

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Запись: ' + $(e.currentTarget).data('group')
      name = $('#direction-user-name').val()
      phone = $('#direction-user-phone').val()
      email = $('#direction-user-email').val()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#direction-user-name').val() is ''
        $('#direction-user-name').addClass '_invalid'
      else
        $('#direction-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#direction-user-email').val())
        $('#direction-user-email').addClass '_invalid'
      else
        $('#direction-user-email').removeClass('_invalid').addClass '_valid'
      if $('#direction-user-phone').val() is ''
        $('#direction-user-phone').addClass '_invalid'
      else
        $('#direction-user-phone').removeClass('_invalid').addClass '_valid'