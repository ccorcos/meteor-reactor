{div, form, input} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item} = Reactor.components


Reactor.component
  name: 'Login'
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    username: ''
    password: ''
    error: ''

  submitForm: (e) ->
    e.preventDefault()
    Meteor.loginWithPassword @state.username, @state.password, (err) =>
      if err 
        @setState {error: err.reason}
      else
        Reactor.go('leaderboard')

  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Login')
      ])
      (Content {header: true}, [
        (form {onSubmit: @submitForm}, [
          (List {}, [
            (Item {input: true}, [
              (input {type:'text', placeholder:'username', valueLink: @linkState('username')})
            ])
            (Item {input: true}, [
              (input {type:'password', placeholder:'password', valueLink: @linkState('password')})
            ])
          ])
          do => if @state.error then (Error @state.error)
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
    error: ''

  submitForm: (e) ->
    e.preventDefault()
    if @state.password isnt @state.verify
      @setState {error: 'Passwords don\'t match'}
      return
      
    Accounts.createUser {username: @state.username, password: @state.password, profile:{score:0}}, (err) =>
      if err 
        @setState {error: err.reason}
      else
        Reactor.go('leaderboard')

  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Signup')
      ])
      (Content {header: true}, [
        (form {onSubmit: @submitForm}, [
          (List {}, [
            (Item {input: true}, [
              (input {type:'text', placeholder:'username', valueLink: @linkState('username')})
            ])
            (Item {input: true}, [
              (input {type:'password', placeholder:'password', valueLink: @linkState('password')})
            ])
            (Item {input: true}, [
              (input {type:'password', placeholder:'verify', valueLink: @linkState('verify')})
            ])
          ])
          do => if @state.error then (Error @state.error)
          (Padding [
            (Button {type:'block', color:'balanced'}, 'signup')
            (Button {type:'block', color:'dark', div:true, onClick: -> 
              Reactor.go('login')}, 'login')
          ])
        ])
      ])
    ])

