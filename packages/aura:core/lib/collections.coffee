@AuraColl = {}

@AuraHistory = new Mongo.Collection('auraHistory')
@AuraPages = new Mongo.Collection('auraPages')

AuraColl['auraHistory'] = AuraHistory
AuraColl['auraPages'] = AuraPages