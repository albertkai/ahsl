@Events = new Mongo.Collection 'events'
@News = new Mongo.Collection 'news'
@Requests = new Mongo.Collection 'requests'
@Slider = new Mongo.Collection 'slider'
@SummerSlider = new Mongo.Collection 'summerSlider'
@CountrySlider = new Mongo.Collection 'countrySlider'
Slider.allow {

  insert: (userId)->
    if userId
      true

  update: (userId)->
    if userId
      true

  remove: (userId)->
    if userId
      true

}

SummerSlider.allow {

  insert: (userId)->
    if userId
      true

  update: (userId)->
    if userId
      true

  remove: (userId)->
    if userId
      true

}

CountrySlider.allow {

  insert: (userId)->
    if userId
      true

  update: (userId)->
    if userId
      true

  remove: (userId)->
    if userId
      true

}

Events.allow {

  insert: (userId)->
    if userId
      true

  update: (userId)->
    if userId
      true

  remove: (userId)->
    if userId
      true

}

Requests.allow {

  insert: (userId)->
    if userId
      true

  update: (userId)->
    if userId
      true

  remove: (userId)->
    if userId
      true

}


AuraColl['events'] = Events
AuraColl['news'] = News
AuraColl['requests'] = Requests
AuraColl['slider'] = Slider
AuraColl['summerSlider'] = SummerSlider
AuraColl['countrySlider'] = CountrySlider