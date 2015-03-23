@AuraGallery = new Mongo.Collection 'auraGallery'
AuraColl['auraGallery'] = AuraGallery

AuraGallery.allow {

  insert: (userId)->
    if Roles.userIsInRole userId, ['admin']
      true

  update: (userId)->
    if Roles.userIsInRole userId, ['admin']
      true

  remove: (userId)->
    if Roles.userIsInRole userId, ['admin']
      true

}