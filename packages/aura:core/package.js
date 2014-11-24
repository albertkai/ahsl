Package.describe({
  name: 'aura:core',
  summary: 'Sexy cms for meteor world',
  version: '1.0.0',
  git: ' /* Fill me in! */ '
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('standard-app-packages');
  api.use('alanning:roles@1.2.12');
  api.use('phuocd:ace@1.0.0', 'client');
  api.use(['session', 'templating', 'underscore', 'coffeescript', 'spacebars' ,'accounts-password', 'jquery', 'less'], 'client');
  api.use(['underscore', 'coffeescript','accounts-password'], 'server');
  api.use(['mongo'], ['client', 'server']);
  api.addFiles([ 'client/ui/addImageButton.html', 'client/ui/auraUsersModal.html', 'client/ui/adminPanel.html', 'client/ui/auraLoginModal.html',
      'client/ui/auraModal.html', 'client/ui/editor.html', 'client/aura.html', 'client/aura.less', 'client/less/admin.lessimport', 'client/less/editor.lessimport',
  'client/less/mixins.lessimport', 'client/less/animo.css', 'client/third_party/canvasresize.js', 'client/third_party/mousetrap.js', 'client/third_party/utils.js'], 'client');
  api.addFiles(['lib/collections.coffee', 'lib/config.json', 'client/aura.coffee'], ['client', 'server']);
  api.addFiles(['server/server.coffee', 'server/seed.coffee'], 'server');
//  api.export('Aura', ['client', 'server'])
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('aura:core');
  api.addFiles('aura:core-tests.js');
});

Npm.depends({
    "data-uri-to-buffer": "0.0.3",
    "aws-sdk": "2.0.17"
})
