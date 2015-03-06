{div, form, input, a} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Search'
  mixins: [React.addons.LinkedStateMixin]


  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Search')
      ])
      (Content {header: true}, [
        "nothing here yet",
        (a {href:"/login"}, "login")
      ])
      (Tabbar {active: 'search'})
    ])

