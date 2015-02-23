{div, form, input, span} = Reactor.DOM
{Ionic, Header, Title, Footer, Content, Padding, Button, List, Item} = Reactor.components


Player = Reactor.component
  name: 'Player'

  getDefaultProps: ->
    selected: false
    player:
      _id: 0
      username: ''
      profile:
        score: 0

  selectPlayer: ->
    Session.set('selectedPlayerId', @props.player._id)

  subscribe: ->
    Meteor.subscribe('players')

  render: ->

    options = 
      onClick: @selectPlayer

    if @props.selected
      options.color = 'dark'

    (Item options, [
      @props.player.username
      (span {className:'item-note'}, @props.player.profile?.score)
    ])


Reactor.component
  name: 'Leaderboard'

  getMeteorState:
    players: -> Meteor.users.find({}, { sort: { 'profile.score': -1, username: 1 } }).fetch()
    selectedPlayer: -> Meteor.users.findOne(Session.get('selectedPlayerId'))
  
  incPlayerScore: ->
    Meteor.call('incPlayer', @state.selectedPlayer._id)

  render: ->

    players = @state.players.map (player) =>
      (Player {player: player, selected: (@state.selectedPlayer?._id is player._id)})

    footer = (Footer [
      Title "Select a player"
    ])

    if @state.selectedPlayer
      footer = (Footer {onClick: @incPlayerScore}, [
        Title 'Add 5 points'
      ])

    (Ionic {}, [
      (Header  [
        Title 'Leaderboard'
        Button {type: 'icon', icon: 'log-out', color: 'primary', onClick: -> Meteor.logout()}
      ])
      (Content {header:true, footer:true}, [
        (List {}, players)
      ])
      footer
    ])
