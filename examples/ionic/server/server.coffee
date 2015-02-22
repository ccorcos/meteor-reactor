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
        score: Math.floor(Random.fraction() * 10) * 5
