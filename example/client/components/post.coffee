{div, h2, p,  form, input, a, span} = Reactor.DOM
{Ionic, Header, Username, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components

Reactor.component
  name: 'Post'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getDefaultProps: ->
    postId: ''
    back: '/'

  getMeteorState:
    post: -> Posts.findOne(@props.postId)
    userId: -> Meteor.userId()

  back: ->
    FlowRouter.go(@props.back)

  deletePost: ->
    @stopAutoruns()
    Meteor.call 'deletePost', @state.post._id, (err) =>
      if err
        alert(err.reason)
      @back()
        

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
        do =>
          if @state.userId is @state.post.userId
            (Padding [
              (Button {type:'block', color:'assertive', onClick: @deletePost}, 'delete')
            ])
      ])
      (Tabbar {active: @props.back})
    ])
