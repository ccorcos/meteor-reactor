{div, form, input, a} = Reactor.DOM
{Ionic, Header, Title, Error, Content, Padding, Button, List, Item, Tabbar, TabItem} = Reactor.components


Reactor.component
  name: 'Plus'
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    title: ''
    error: ''

  submitForm: (e) ->
    e.preventDefault()

    if @state.title is ''
      @setState {error: 'Please fill out a title'}
      return

    Meteor.call "newPost", @state.title, (err, postId) =>
      if err
        @setState {error: err.reason}
      else
        FlowRouter.go('/post/'+postId)

  render: ->
    (Ionic {}, [
      (Header  [
        (Title 'Plus')
      ])
      (Content {header: true}, [
        (form {onSubmit: @submitForm}, [
          (List {}, [
            (Item {input: true}, [
              (input {type:'text', placeholder:'title', valueLink: @linkState('title')})
            ])
          ])
          do => if @state.error then (Error @state.error)
          (Padding [
            (Button {type:'block', color:'dark'}, 'submit')
          ])
        ])
      ])
      (Tabbar {active: '/plus'})
    ])