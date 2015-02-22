Meteor.startup ->
  
  if Players.find().count() == 0

    names = [
      'Ada Lovelace'
      'Grace Hopper'
      'Marie Curie'
      'Carl Friedrich Gauss'
      'Nikola Tesla'
      'Claude Shannon'
    ]

    for name in names
      Players.insert
        name: name
        score: Math.floor(Random.fraction() * 10) * 5
