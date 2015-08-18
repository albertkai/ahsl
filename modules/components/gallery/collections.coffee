@AuraGallery = new Mongo.Collection 'auraGallery'
AuraColl['auraGallery'] = AuraGallery

AuraGallery.allow {

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