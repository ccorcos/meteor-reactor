
# Destructure what we need
{div, span, button, h1} = Reactor.DOM

Player = Reactor.component
  name: 'Player'

  propTypes:
    player: React.PropTypes.object
    selected: React.PropTypes.bool

  getDefaultProps: ->
    selected: false
    player:
      _id: 0
      name: ''
      score: 0

  selectPlayer: ->
    Session.set('selectedPlayerId', @props.player._id)

  render: ->

    classes = React.addons.classSet
      'player': true
      'selected': @props.selected

    (div {className:classes, onClick: @selectPlayer}, [
      (span {className:"name" }, @props.player.name )
      (span {className:"score"}, @props.player.score)
    ])

Leaderboard = Reactor.component
  name: 'Leaderboard'

  getMeteorState:
    players: -> Players.find({}, { sort: { score: -1, name: 1 } }).fetch()
    selectedPlayer: -> Players.findOne(Session.get('selectedPlayerId'))
  
  incPlayerScore: ->
    Players.update(@state.selectedPlayer._id, {$inc: {score: 5}})

  render: ->

    players = @state.players.map (player) =>
      (Player {player: player, selected: (@state.selectedPlayer?._id is player._id), key: player._id})

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


Meteor.startup ->
  Reactor.render  (div {className:"outer"}, [
                    (div  {className: "logo"})
                    (h1   {className: "title"},    'Leaderboard')
                    (div  {className: "subtitle"}, 'Select a scientist to give them points')
                    (Leaderboard())
                  ])
