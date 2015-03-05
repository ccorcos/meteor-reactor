{div, span, button, h1, label, a, i} = Reactor.DOM


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

Tabs = Reactor.component
  name: 'Tabs'

  render: ->
    (div {className: 'tabs-icon-only'}, [
      (div {className: 'tabs'}, @props.children)
    ])

TabItem = Reactor.component
  name: 'TabItem'

  getDefaultProps: ->
    icon: ''
    active: false
    href: ''

  render: ->

    classSeti = {'icon': true}
    classSeti[@props.icon] = true
    classesi = React.addons.classSet(classSeti)

    classSeta = {'tab-item': true}
    classSeta.active = @props.active
    classesa = React.addons.classSet(classSeta)

    (a {className: classesa, href: @props.href}, [
      (i {className: classesi})
    ])

Reactor.component
  name: 'Tabbar'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getMeteorState:
    path: -> FlowRouter.reactiveCurrent().path

  render: ->
    path = @state.path

    (Tabs [
      (TabItem {icon:'ion-ios-home', active: path is '/', href: '/'})
      (TabItem {icon:'ion-ios-search', active: path is '/search', href: '/search'})
      (TabItem {icon:'ion-ios-plus-empty', active: path is '/plus', href: '/plus'})
      (TabItem {icon:'ion-ios-list-outline', active: path is '/activity', href: '/activity'})
      (TabItem {icon:'ion-ios-person', active: path is '/settings', href: '/settings'})
    ])