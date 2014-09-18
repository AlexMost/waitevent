React = require 'react'
{div, h3, p} = React.DOM
{has_parent} = require './utils'

Popover = React.createClass
    displayName: "Popover"

    getInitialState: ->
        visible: false
        top: 0
        left: 0

    checkIfClose: (ev) ->
        isOutside = ! has_parent(@getDOMNode(), ev.target)
        isOutsideSource = ! has_parent(
            @props.source().getDOMNode(), ev.target)
        @hide() if isOutside and isOutsideSource

    componentDidUpdate: ->
        if @state.visible
            $(document).on 'click', @checkIfClose
        else
            $(document).unbind 'click', @checkIfClose


    show: ->
        jnode = $ @props.source().getDOMNode()
        self_node = $ @getDOMNode()
        self_width = self_node.width()

        {top: s_top, left: s_left} = jnode.position()
        p_top = s_top + jnode.height()

        s_width = jnode.width()
        s_center = s_left + s_width/2
        p_left = s_center - self_width/2
        @setState {top: p_top, left: p_left, visible: true}

    hide: -> @setState {visible: false}

    toggle: -> if @state.visible then @hide() else @show()
        
    render: ->
        wrapper_props =
            className: "popover bottom"
            style:
                top: @state.top
                left: @state.left
                display: "block"
        
        wrapper_props.style.visibility = if @state.visible
            "visible"
        else
            "hidden"

        div wrapper_props,
            div {className: "arrow"}
            if @props.title
                h3 {className:"popover-title"},
                    @props.title

            div {className:"popover-content"},
                p {}, @props.children

module.exports = Popover