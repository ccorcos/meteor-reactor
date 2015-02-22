Package.describe({
  name: 'ccorcos:reactor',
  version: '0.12.2',
  summary: 'React for Meteor.',
  git: 'https://github.com/ccorcos/meteor-reactor'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1');
  api.use([
    'coffeescript',
    'underscore',
  ], 'client');

  api.addFiles([
    'react.js',
    'reactor.coffee',
  ], 'client');
});