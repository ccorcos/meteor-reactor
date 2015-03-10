@Reactor = {}

Reactor = @Reactor

# Coffee Syntax Jazz
build_tag = (tag) ->
  (options...) ->
    # first argument is empty props
    options.unshift {} unless typeof options[0] is 'object' and not _.isArray(options[0])
    opts = options

    React.DOM[tag].apply @, options

Reactor.DOM = do ->
  object = {}
  for element in Object.keys(React.DOM)
      object[element] = build_tag element
  object

Reactor.render = (component) -> 
  React.render(component, document.body)


# Meteor mixin
MeteorStateMixin =

  startAutoruns: ->
    unless @computations
      @computations = []

    initialState = {}
    computations = @computations
    for name, func of @getMeteorState
      do (name, func) =>
        comp = Tracker.autorun (c)=>
          value = func.bind(this)()
          if c.firstRun
            initialState[name] = value
          else
            s = {}
            s[name] = value
            @setState(s)
        computations.push(comp)
    return initialState

  stopAutoruns: ->
    if @computations
      for computation in @computations
        computation.stop?()
      @computations = null

  getInitialState: ->
    @startAutoruns()

  componentWillUnmount: ->
    @stopAutoruns()


MeteorSubsMixin =
  getInitialState: ->
    loading: do -> if @sub?.ready then not @sub.ready() else false

  componentWillMount: ->
    unless @subscriptions
      @subscriptions = []

    subs = @getMeteorSubs()

    c = Tracker.autorun =>
      loading = false
      for sub in subs
        unless sub?.ready?()
          loading = true
      @setState {loading}

    for sub in subs
      @subscriptions.push(sub)

    @subscriptions.push(c)

  stopSubs: ->
    if @subscriptions
      for sub in @subscriptions
        sub.stop?()
      @subscriptions = null
      
  componentWillUnmount: ->
    @stopSubs()

Reactor.mixins =
  MeteorStateMixin: MeteorStateMixin
  MeteorSubsMixin: MeteorSubsMixin

Reactor.components = {}

Reactor.component = (obj) ->

  Element = React.createClass.apply(React, [obj])

  func = (options...) ->
    options.unshift {} unless typeof options[0] is 'object' and not _.isArray(options[0])
    React.createElement.apply(React, [Element].concat(options))

  name = obj.name or obj.displayName
  if name
    Reactor.components[name] = func

  return func


Reactor.renderComponent = (args...) -> 
  componentName = args[0]
  rest = args[1..]
  func = Reactor.components[componentName]
  if func
    React.render(func.apply({}, rest), document.body)
  else
    console.log "WARNING: unknown component", componentName