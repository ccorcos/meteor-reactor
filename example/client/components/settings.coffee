{div, form, input, a} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Settings'
  mixins: [React.addons.LinkedStateMixin]


  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Settings')
      ])
      (Content {header: true}, [
        "nothing here yet",
        (a {href:"/login"}, "login")
      ])
      (Tabbar {active: '/settings'})
    ])

