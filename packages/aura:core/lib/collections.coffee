@AuraColl = {}

@AuraHistory = new Mongo.Collection('auraHistory')
@AuraPages = new Mongo.Collection('auraPages')
@AuraLogs = new Mongo.Collection('auraLogs')
@AuraSettings = new Mongo.Collection('auraSettings')

AuraColl['auraHistory'] = AuraHistory
AuraColl['auraPages'] = AuraPages
AuraColl['auraLogs'] = AuraLogs
AuraColl['auraSettings'] = AuraSettings