Meteor.startup ->
  if Meteor.users.find().count() is 0
    console.log "creating fake users and fake posts"

    for name in [0...20]
      u = Fake.user()
      Accounts.createUser 
        username: u.fullname.replace /\s+/g, ''
        email: u.email
        password: "123456"

    for post in [0...50]
      user = _.sample(Meteor.users.find().fetch())
      Posts.insert
        title: Fake.sentence(3)
        userId: user._id
        date: Date.now()