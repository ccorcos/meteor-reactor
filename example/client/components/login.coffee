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
        @afterLogin()

  goToSignup: ->
    FlowRouter.go('/signup')

  afterLogin: ->
    FlowRouter.go('/')

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
            (Button {type:'block', color:'balanced', div:true, onClick: @goToSignup}, 'signup')
          ])
        ])
      ])
    ])

