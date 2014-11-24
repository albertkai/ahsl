

Template.contacts.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "http://maps.google.com/maps/api/js?sensor=false&libraries=places&callback=initializeMap"
  script.id = "googleMaps"
  if $('#googleMaps').length > 0
    initializeMap()
  else
    document.body.appendChild(script)


@initializeMap = ->

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