Package.describe({
  name: 'ccorcos:reactor',
  version: '0.12.3',
  summary: 'An opinionated package for integrating React with Meteor.',
  git: 'https://github.com/ccorcos/meteor-reactor'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1');
  api.use([
    'coffeescript',
    'underscore',
  ], 'client');

  api.addFiles([
    'lib/react.js',
    'lib/reactor.coffee',
  ], 'client');
});