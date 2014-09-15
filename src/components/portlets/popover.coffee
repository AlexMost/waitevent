React = require 'react'
{div, h3, p} = React.DOM


Popover = React.createClass
    displayName: "Popover"

    getInitialState: ->
        visible: true
        top: 0
        left: 0

    componentDidMount: ->
        jnode = $ @props.source.getDOMNode()
        self_node = $ @getDOMNode()
        self_width = self_node.width()

        {top: s_top, left: s_left} = jnode.position()
        p_top = s_top + jnode.height()

        s_width = jnode.width()
        s_center = s_left + s_width/2
        p_left = s_center - self_width/2
        @setState {top: p_top, left: p_left}

    render: ->
        wrapper_props =
            className: "popover bottom"
            style:
                top: @state.top
                left: @state.left

        if @state.visible
            wrapper_props['style']['display'] = "block"

        div wrapper_props,
            div {className: "arrow"}
            if @props.title
                h3 {className:"popover-title"},
                    @props.title

            div {className:"popover-content"},
                p {}, @props.children


module.exports = Popover