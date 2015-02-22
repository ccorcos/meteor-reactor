{input, a} = Reactor.DOM


Reactor.route
  name: 'login'
  
Reactor.route
  name: 'signup'

Reactor.route
  name: 'home'
  path: '/'
  action: ->
    url = Reactor.path('login')
    c = (a {href: url}, 'login')
    Reactor.render(c)
