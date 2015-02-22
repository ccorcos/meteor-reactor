@Reactor = {}
Reactor = @Reactor

# Coffee Syntax Jazz
build_tag = (tag) ->
  (options...) ->
    options.unshift {} unless typeof options[0] is 'object' and not _.isArray(options[0])
    React.DOM[tag].apply @, options

Reactor.DOM = do ->
  object = {}
  for element in Object.keys(React.DOM)
      object[element] = build_tag element
  object


# Render to the body
Reactor.render = (component) -> 
  React.render(component, document.body)

# Meteor mixin
MeteorMixin =
  getInitialState: ->
    s = {}
    for name, func of @getMeteorState
      s[name] = func()
    return s

  componentWillMount: ->
    computations = []
    for name, func of @getMeteorState
      do (name, func) =>
        comp = Tracker.autorun (c)=>
          value = func()
          unless c.firstRun
            s = {}
            s[name] = value
            @setState(s)
        computations.push(comp)
    @computations = computations

  componentWillUnmount: ->
    if @computations
      for computation in @computations
        computation.stop()
      @computations = null


Reactor.mixins =
  PureRender: React.addons.PureRenderMixin
  MeteorMixin: MeteorMixin

# Create a component
Reactor.components = {}

Reactor.component = (obj) ->

  if 'displayName' of obj
    obj.name = obj.displayName
  if 'name' of obj
    obj.displayName = obj.name


  unless 'mixins' of obj
      obj.mixins = []

  if 'getMeteorState' of obj
    unless Reactor.mixins.MeteorMixin in obj.mixins
      obj.mixins.push(Reactor.mixins.MeteorMixin)

  # I dont see a case where we wouldnt want this...
  # I guess all inputs must be controlled...
  unless Reactor.mixins.PureRender in obj.mixins
    obj.mixins.push(Reactor.mixins.PureRender)

  Element = React.createClass.apply(React, [obj])

  func = (options...) ->
    options.unshift {} unless typeof options[0] is 'object' and not _.isArray(options[0])
    React.createElement.apply(React, [Element].concat(options))

  if 'name' of obj
    Reactor.components[obj.name] = func

  return func


