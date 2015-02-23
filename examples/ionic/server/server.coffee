Meteor.startup ->
  if Meteor.users.find().count() is 0
    
    names = [
      'Ada Lovelace'
      'Grace Hopper'
      'Marie Curie'
      'Carl Friedrich Gauss'
      'Nikola Tesla'
      'Claude Shannon'
    ]

    for name in names
      Accounts.createUser
        username: name
        password: '123456'
        profile:
          score: Math.floor(Random.fraction() * 10) * 5

Meteor.publish 'players', () ->
  if @userId
    Meteor.users.find({}, {fields:{username:1, 'profile.score':1}})