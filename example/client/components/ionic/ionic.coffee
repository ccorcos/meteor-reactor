{div, span, input, button, h1, label, a, i} = Reactor.DOM


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
  name: 'SearchHeader'
  mixins: [Reactor.mixins.MeteorStateMixin]

  getDefaultProps: ->
    color: 'light'  

  clearSearch: ->
    @props.search.set('')

  searchChange: (e) ->
    @props.search.set(e.target.value)

  getMeteorState:
    text: -> @props.search.get()

  render: ->

    classSet = 
      'bar': true
      'bar-header': true
      'item-input-inset': true

    if @props.color then classSet["bar-#{@props.color}"] = true

    classes = React.addons.classSet(classSet)

    (div {className:classes}, [
      (label {className:'positive item-input-wrapper'}, [
        (i {className:'icon ion-ios-search placeholder-icon'})
        (input {type:"search", placeholder:"Search", value:@state.text, onChange:@searchChange})
        do =>
          if @state.text isnt ''
            (i {className:'icon ion-ios-close placeholder-icon', onClick: @clearSearch})
      ])
    ])

# <div class="">
#   <label class="item-input-wrapper">
#     <i class="icon ion-ios7-search placeholder-icon"></i>
#     <input type="search" placeholder="Search">
#   </label>
#   <button class="button button-clear">
#     Cancel
#   </button>
# </div>



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
    padding: false

  render: ->

    classes = React.addons.classSet
      'content': true
      'overflow-scroll': true
      'padding': @props.padding
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
    classSeti["ion-#{@props.icon}"] = true
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

  getDefaultProps: ->
    active: 'home'

  render: ->
    path = @state.path

    (Tabs [
      (TabItem {icon:'ios-home', active: @props.active is '/', href: '/'})
      (TabItem {icon:'ios-search', active: @props.active is '/search', href: '/search'})
      (TabItem {icon:'ios-plus-empty', active: @props.active is '/plus', href: '/plus'})
      (TabItem {icon:'ios-list-outline', active: @props.active is '/activity', href: '/activity'})
      (TabItem {icon:'ios-person', active: @props.active is '/settings', href: '/settings'})
    ])