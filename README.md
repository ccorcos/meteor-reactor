# Reactor - React for Meteor

This is an opinionated package for integrating React with Meteor.

## Getting Started

    meteor add ccorcos:reactor

The best way to get started is to read the (React.js documentation)[http://facebook.github.io/react/docs/getting-started.html] and just check out the [examples](/examples).

### Components

React components can be generated with `Reactor.component`. This will add the `MeteorStateMixin` and the `MeteorSubscriptionMixin` if necessary. When you create a Reactor component, you can reactively set the state of the component using `getMeteorState` and you can subscribe to collections with `subscribe`. These subscriptions will be stopped when the component unmounts, but you can use `Reactor.subscribe` which wraps [meteorhacks:subs-manager](https://github.com/meteorhacks/subs-manager) to cache your subscriptions. Any component that has subscriptions will have a `state.loading` that specifies whether the subscription is ready or not. 

```coffee
Reactor.component
  name: 'Leaderboard'

  getMeteorState:
    players:        -> Meteor.users.find({}, { sort: { 'profile.score': -1, username: 1 } }).fetch()
    selectedPlayer: -> Meteor.users.findOne(Session.get('selectedPlayerId'))
  
  subscribe: ->
    Reactor.subscribe('players')

  incPlayerScore: ->
    Meteor.call('incPlayer', @state.selectedPlayer._id)

  render: ->
    players = @state.players.map (player) =>
      (Player {player: player, selected: (@state.selectedPlayer?._id is player._id)})

    board = (div {className: "leaderboard"}, players)

    if @state.selectedPlayer
      (div [
        (board)
        (div {className: "details"}, [
          (span   {className: "name"}, @state.selectedPlayer.name)
          (button {className: "inc", onClick: @incPlayerScore}, 'Add 5 points')
        ])
      ])
    else
      (div [
        (board)
        (div {className:"message"}, 'Click a player to select')
      ])
```

### Syntax

I didn't want to use JSX, so I created some functions that makes Coffeescript syntax much nicer and it almost looks like Lisp.

`Reactor.component` wraps `React.createClass` with `React.createComponent` so you can use these components directly as functions. All Reactor components can be found in `Reactor.components`. When building your DOM, you can first use a destructuring assignment for the components you need.

```coffee
{div, span, button, h1} = Reactor.DOM
{Player} = Reactor.components
```

When building the DOM, each component is a function where the second argument is an optional object of props. The third optional argument is child or an array of children. Using a Lisp-like syntax makes your DOM structuring very elegant.

```coffee
(Header  [
  (Title 'Signup')
])
(Content {header: true}, [
  (form {onSubmit: @submitForm}, [
    (List {}, [
      (Item {input: true}, [
        (input {type:'text', placeholder:'username'})
      ])
      (Item {input: true}, [
        (input {type:'password', placeholder:'password'})
      ])
      (Item {input: true}, [
        (input {type:'password', placeholder:'verify'})
      ])
    ])
    do => if @state.error then (Error @state.error)
    (Padding [
      (Button {type:'block', color:'balanced'}, 'signup')
    ])
  ])
])
```

### Rendering

To render components, you can use `React.render(component, dom_parent)` or you can use `Reactor.render(component)` to render the component to the `document.body`.

### Routing

Reactor also wraps [iron:router](https://github.com/iron-meteor/iron-router) to render React(or) components as opposed to Blaze templates. The syntax if very similar to Iron Router, only `Reactor.route` takes one object as an argument and requires a name. Any parameters specified in the route path are passed as props to the component with the specified route name. You can also optionally specify the component name so that it doesn't have to match the route name.

```coffee
Reactor.onBeforeAction ->
    if not Meteor.userId()
      @redirect 'login'
    else
      @next()
  ,
    except: ['login', 'signup']

Reactor.route
  name: 'login'
  
Reactor.route
  name: 'signup'

Reactor.route
  name: 'leaderboard'
  path: '/'
  #component: 'Leaderboard'
```

## To Do

- animation!
- [Velocity animation mixin](https://gist.github.com/tkafka/0d94c6ec94297bb67091).
- Observable streams for UI event handling would be nice - make a side menu!
