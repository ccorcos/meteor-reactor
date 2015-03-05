{div, form, input, a} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item} = Reactor.components


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
      
    Accounts.createUser {username: @state.username, password: @state.password}, (err) =>
      if err 
        @setState {error: err.reason}
      else
        @afterSignup()

  goToLogin: ->
    FlowRouter.go('/login')

  afterSignup: ->
    FlowRouter.go('/')

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
            (Button {type:'block', color:'dark', div:true, onClick: @goToLogin}, 'login')
          ])
        ])
      ])
    ])

