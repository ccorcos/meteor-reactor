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
    'iron:router@1.0.7',
    'meteorhacks:subs-manager@1.3.0',
  ], 'client');

  // api.use('iron:router', 'client', {weak: true});

  api.addFiles([
    'lib/react.js',
    'lib/reactor.coffee',
    'lib/routing.coffee'
  ], 'client');
});