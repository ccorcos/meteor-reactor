{div, form, input, a, h2, p} = Reactor.DOM
{Ionic, Header, Username, SearchHeader, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Search'
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    search: new ReactiveVar('')

  render: ->
    (Ionic {}, [
      (SearchHeader {search:@state.search})
      (Content {header: true}, [
        (PostResults {search: @state.search})
      ])
      (Tabbar {active: '/search'})
    ])


PostResults = Reactor.component
  name: 'PostResults'
  mixins: [Reactor.mixins.MeteorStateMixin]

  goToPost: (post) ->
    FlowRouter.go('/post/' + post._id)

  getMeteorState:
    posts: ->
      filter = new RegExp(@props.search.get(), 'ig')
      Posts.find({title: filter}, {sort: {name:1, date:-1}})?.fetch()

  render: ->
    (List {}, @state.posts?.map (post) =>
      (Item {key:post._id, back: '/search', onClick: (do (post) => => @goToPost(post))}, [
        (h2 post.title)
        (p {}, [
          (Username {userId: post.userId, key: post.userId})
        ])
      ])
    )


