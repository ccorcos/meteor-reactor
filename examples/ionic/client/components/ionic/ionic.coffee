{div, span, button, h1, label} = Reactor.DOM


Reactor.component
  name: 'Ionic'
  render: ->
    (div {className: 'ionic'}, [
      (div {className:"ionic-body", style:{position:'absolute'}}, @props.children)
    ])


Reactor.component
  name: 'Header'

  getDefaultProps: ->
    title: ''

  render: ->
    classes = React.addons.classSet
      'bar': true
      'bar-header': true
      'bar-positive': true

    (div {className:classes}, [
      (h1 {className:"title" }, @props.title )
    ])

Reactor.component
  name: 'Content'

  getDefaultProps: ->
    header: true

  render: ->

    classes = React.addons.classSet
      'content': true
      'has-header': @props.header

    (div {className:classes}, [
      (@props.children)
    ])


# This is really just a partial application on div with styles.
Reactor.component
  name: 'Padding'

  render: ->
    (div {className:'padding'}, [
      (@props.children)
    ])


Reactor.component
  name: 'List'

  render: ->

    classes = React.addons.classSet
      'list': true

    (div {className:classes}, [
      (@props.children)
    ])


Reactor.component
  name: 'Item'

  getDefaultProps: ->
    input: false

  render: ->

    classes = React.addons.classSet
      'item': true
      'item-input': true

    (label {className:classes}, [
      (@props.children)
    ])


Reactor.component
  name: 'Button'

  getDefaultProps: ->
    type: ''
    color: 'light'
    div: false

  render: ->
    classes = {'button': true}
    if @props.type then classes["button-#{@props.type}"] = true
    if @props.color then classes["button-#{@props.color}"] = true
    classes = React.addons.classSet(classes)

    if @props.div
      (div {className:classes, onClick:@props.onClick}, [
        (@props.children)
      ])
    else
      (button {className:classes, onClick:@props.onClick}, [
        (@props.children)
      ])
