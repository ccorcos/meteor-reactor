{div, form, input} = Reactor.DOM
{Ionic, Header, Content, Padding, Button, List, Item} = Reactor.components


Reactor.component
  name: 'Login'
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    username: ''
    password: ''

  submitForm: (e) ->
    e.preventDefault()
    console.log @state.username, @state.password

  render: ->
    (Ionic {}, [
      (Header  {title: "Login"})
      (Content {}, [
        (form {onSubmit: @submitForm}, [
          (List {}, [
            (Item {}, [
              (input {type:'text', placeholder:'username', valueLink: @linkState('username')})
            ])
            (Item {}, [
              (input {type:'password', placeholder:'password', valueLink: @linkState('password')})
            ])
          ])
          (Padding [
            (Button {type:'block', color:'dark'}, 'login')
            (Button {type:'block', color:'balanced', div:true, onClick: -> Reactor.go('signup')}, 'signup')
          ])
        ])
      ])
    ])



Reactor.component
  name: 'Signup'
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    username: ''
    password: ''
    verify: ''

  submitForm: (e) ->
    e.preventDefault()
    console.log @state.username, @state.password

  render: ->
    (Ionic {}, [
      (Header  {title: "Signup"})
      (Content {}, [
        (form {onSubmit: @submitForm}, [
          (List {}, [
            (Item {}, [
              (input {type:'text', placeholder:'username', valueLink: @linkState('username')})
            ])
            (Item {}, [
              (input {type:'password', placeholder:'password', valueLink: @linkState('password')})
            ])
            (Item {}, [
              (input {type:'password', placeholder:'verify', valueLink: @linkState('verify')})
            ])
          ])
          (Padding [
            (Button {type:'block', color:'balanced'}, 'signup')
            (Button {type:'block', color:'dark', div:true, onClick: -> 
              Reactor.go('login')}, 'login')
          ])
        ])
      ])
    ])

