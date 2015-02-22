iron router wrapper
 - component -- what component to render?
 - render a blank template every time and always call @next
 - before function with possibly redirect
 - action renders the associated component -- nonreactive!
 - path, pass @params as props
 - after

react meteor mixin
  -> state
  -> subscribe, @ready


Reactor

Reactor.route
  name: 'login'
  #path: '/login'
  #component: 'login' or 'Login'
  before: ->
    @params, etc.
    whatever you want,
    if something then @redirect elsewhere
  action: ->
    if you have an action, youre responsible for rendering!
    ReactRender Login, {userId: @params._id}
  after: ->
    @params, etc.
    maybe log what happened or something


Reactor.components.login

Login = Reactor.component 'Login', 
  # reactive state.
  state:
    'players': -> Players.find(@props.whatever)
    'selectedPlayer': -> Players.findOne()
  render: ->
    blah blah blah








- animate between pages

- Observable streams for UI event handling would be nice - make a side menu!

https://gist.github.com/tkafka/0d94c6ec94297bb67091

clone iron router