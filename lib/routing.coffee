Reactor = @Reactor

capitaliseFirstLetter = (string) -> string.charAt(0).toUpperCase() + string.slice(1)

Reactor.route = (obj) ->

  keys = [
    'name'
    'path'
    'component'
    'before'
    'action'
    'after'
  ]
  
  obj = _.pick(obj, keys)

  # render some phony blaze templates.
  obj.template = 'reactor'
  obj.layout = 'layout'

  # find the component to render
  component = null
  if obj.component
    component = Reactor.components[obj.component]
  else
    component = Reactor.components[obj.name]
    unless component
      component = Reactor.components[capitaliseFirstLetter(obj.name)]

  # clean up the object we pass to iron router
  name = obj.name
  obj = _.omit(obj, ['component', 'name'])

  # make sure the action is non-reactive by default
  action = obj.action
  if action
    obj.action = ->
      Tracker.nonreactive ->
        action()

  # if an actions wasnt sepcified, then render the component 
  # with props as the route params.
  unless action
    obj.action = ->
      Tracker.nonreactive ->
        Reactor.render(component(@params))

  # pass through iron router
  Router.route name, obj

# Iron Router functions accessible through reactor
Reactor.path = Router.path.bind(Router)
Reactor.go = Router.go.bind(Router)