requiredLogin = (path, next) ->
  # this works only because the use of Fast Render
  if Meteor.userId()
    next(null)
  else
    next("/login")

requiredLogout = (path, next) ->
  # this works only because the use of Fast Render
  if Meteor.userId()
    next("/")
  else
    next(null)

FlowRouter.route '/login',
  middlewares: [requiredLogout]
  action: (params) ->
    Reactor.renderComponent "Login"

FlowRouter.route '/signup',
  middlewares: [requiredLogout]
  action: (params) ->
    Reactor.renderComponent "Signup"





FlowRouter.route '/',
  middlewares: [requiredLogin]
  action: (params) ->
    Reactor.renderComponent "Home"

FlowRouter.route '/search',
  middlewares: [requiredLogin]
  action: (params) ->
    Reactor.renderComponent "Search"

FlowRouter.route '/plus',
  middlewares: [requiredLogin]
  action: (params) ->
    Reactor.renderComponent "Plus"

FlowRouter.route '/activity',
  middlewares: [requiredLogin]
  action: (params) ->
    Reactor.renderComponent "Activity"

FlowRouter.route '/settings',
  middlewares: [requiredLogin]
  action: (params) ->
    Reactor.renderComponent "Settings"

FlowRouter.route '/post/:postId',
  middlewares: [requiredLogin]
  action: (params) ->
    Reactor.renderComponent "Post", {postId: params.postId}