{div, form, input, a, h2, p} = Reactor.DOM
{Ionic, Header, Username, SearchHeader, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Search'
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    search: ''

  render: ->
    searchLink = this.linkState('search')
    searchChange = (e) ->
      searchLink.requestChange(e.target.value)

    (Ionic {}, [
      (SearchHeader {searchChange:searchChange, searchLink:searchLink})
      (Content {header: true}, [
        (PostResults {search: @state.search})
      ])
      (Tabbar {active: '/search'})
    ])

PostResults = Reactor.component
  name: 'PostResults'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getDefaultProps: ->
    search: ''

  goToPost: (post) ->
    FlowRouter.go('/post/' + post._id)

  getMeteorState:
    posts: ->
      console.log "autorun", @props.search
      filter = new RegExp(@props.search, 'ig')
      posts = Posts.find({title: filter}, {sort: {name:1, date:-1}})?.fetch()
      console.log "posts", posts?.length
      return posts

  render: ->

    console.log @state.posts?.length
    (List {}, @state.posts?.map (post) ->
      (Item {back: '/search', onClick: (do (post) => => @goToPost(post))}, [
        (h2 post.title)
        (p {}, [
          (Username {userId: post.userId})
        ])
      ])
    )


