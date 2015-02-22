Meteor.methods
  incPlayer: (playerId) ->
    Meteor.users.update(playerId, {$inc: {'profile.score': 5}})
