{div, form, input, a} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Home'
  mixins: [React.addons.LinkedStateMixin]


  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Home')
      ])
      (Content {header: true}, [
        "nothing here yet",
        (a {href:"/login"}, "login")
      ])
      (Tabbar())
    ])

