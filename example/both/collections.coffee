@Posts = new Mongo.Collection('posts')

Meteor.methods
  newPost: (title) ->
    if @userId
      Posts.insert
        title: title
        userId: @userId
        date: Date.now()
  deletePost: (postId) ->
    if @userId
      Posts.remove
        userId: @userId
        _id: postId
