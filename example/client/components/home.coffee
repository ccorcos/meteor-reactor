{div, h2, p,  form, input, a, span} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components



Username = Reactor.component
  name: 'Username'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getDefaultProps: ->
    userId: ''

  getMeteorState:
    username: -> 
      Meteor.users.findOne(@props.userId).username

  render: -> 
    (span {}, @state.username)



Reactor.component
  name: 'Home'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getMeteorState:
    posts: -> Posts.find({}, {sort:{name: 1, date:-1}}).fetch()

  goToPost: (post) ->
    FlowRouter.go('/post/' + post._id)

  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Home')
      ])
      (Content {header: true}, [
        (List {}, @state.posts.map (post) =>
          (Item {back: '/', onClick: (do (post) => => @goToPost(post))}, [
            (h2 post.title)
            (p {}, [
              (Username {userId: post.userId})
            ])
          ])
        )  
      ])
      (Tabbar {active: '/'})
    ])
