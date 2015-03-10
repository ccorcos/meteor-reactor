{div, form, input, a} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Activity'
  mixins: [React.addons.LinkedStateMixin]

  render: ->
    (Ionic {}, [
      (Header  {}, 
        (Title {}, 'Activity')
      )
      (Content {header: true}, [
        "nothing here yet",
        (a {href:"/login"}, "login")
      ])
      (Tabbar {active: 'activity'})
    ])

