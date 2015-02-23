Reactor.onBeforeAction ->
    if not Meteor.userId()
      @redirect 'login'
    else
      @next()
  ,
    except: ['login', 'signup']#, 'forgot', 'reset']


Reactor.route
  name: 'login'
  
Reactor.route
  name: 'signup'

Reactor.route
  name: 'leaderboard'
  path: '/'
