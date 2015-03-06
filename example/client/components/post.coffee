{div, h2, p,  form, input, a, span} = Reactor.DOM
{Ionic, Header, Username, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components

Reactor.component
  name: 'Post'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getDefaultProps: ->
    postId: ''

  getMeteorState:
    post: -> Posts.findOne(@props.postId)

  back: ->
    FlowRouter.go('/')

  render: ->
    (Ionic {}, [
      (Header  [
        (Button {type: 'icon', color: 'list', icon: 'ios-arrow-back', onClick: @back})
        (Title 'Post')
      ])
      (Content {header: true, padding: true}, [
        (h2 @state.post.title)
        (p {}, [
          (Username {userId: @state.post.userId})
        ]) 
      ])
      (Tabbar {active: 'home'})
    ])
