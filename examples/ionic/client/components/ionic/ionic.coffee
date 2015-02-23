{div, span, button, h1, label} = Reactor.DOM


Reactor.component
  name: 'Ionic'
  render: ->
    (div {className: 'ionic'}, [
      (div {className:"ionic-body", style:{position:'absolute'}}, @props.children)
    ])


Reactor.component
  name: 'Title' 
  render: ->
    (h1 {className:"title" }, @props.children )


Reactor.component
  name: 'Header'

  getDefaultProps: ->
    color: 'positive'    

  render: ->

    classSet = 
      'bar': true
      'bar-header': true

    if @props.color then classSet["bar-#{@props.color}"] = true

    classes = React.addons.classSet(classSet)

    (div {className:classes}, @props.children)


Reactor.component
  name: 'Footer'

  getDefaultProps: ->
    color: 'calm'

  render: ->
    classSet = 
      'bar': true
      'bar-footer': true

    if @props.color then classSet["bar-#{@props.color}"] = true

    classes = React.addons.classSet(classSet)

    (div {className:classes, onClick:@props.onClick}, @props.children)


Reactor.component
  name: 'Content'

  getDefaultProps: ->
    header: false
    footer: false

  render: ->

    classes = React.addons.classSet
      'content': true
      'overflow-scroll': true
      'has-header': @props.header
      'has-footer': @props.header

    (div {className:classes}, [
      (@props.children)
    ])


Reactor.component
  name: 'Padding'

  render: ->
    (div {className:'padding'}, [
      (@props.children)
    ])


Reactor.component
  name: 'List'

  render: ->
    (div {className:'list'}, [
      (@props.children)
    ])


Reactor.component
  name: 'Item'

  getDefaultProps: ->
    input: false
    color: 'light'

  render: ->

    classSet = 
      'item': true
      'item-input': @props.input

    if @props.color then classSet["item-#{@props.color}"] = true

    classes = React.addons.classSet(classSet)      

    (label {className:classes, onClick: @props.onClick}, [
      (@props.children)
    ])


Reactor.component
  name: 'Button'

  getDefaultProps: ->
    type: ''
    color: 'light'
    icon: ''
    div: false

  render: ->
    classSet = {'button': true}
    if @props.type then classSet["button-#{@props.type}"] = true
    if @props.color then classSet["button-#{@props.color}"] = true
    if @props.type is 'icon'
      classSet.icon = true
      classSet["ion-#{@props.icon}"] = true

    classes = React.addons.classSet(classSet)

    if @props.div
      (div {className:classes, onClick:@props.onClick}, [
        (@props.children)
      ])
    else
      (button {className:classes, onClick:@props.onClick}, [
        (@props.children)
      ])

Reactor.component
  name: 'Error'

  render: ->
    style = 
      'text-align': 'center'

    (div {style:style}, [
      (span {className: 'assertive'}, @props.children)
    ])