{input, a} = Reactor.DOM


Meteor.startup ->
  Reactor.render Reactor.components.Signup()

# Router.route 'login', ->
#   RenderDom Login()
#   # @next()

# Router.route 'signup', ->
#   RenderDom Signup()
#   # @next()

# Router.route 'home', 
#   path: '/'
#   action: ->
#       RenderDom (a {href: Router.path('login')}, 'login')
#       # @next()