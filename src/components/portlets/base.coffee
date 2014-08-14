React = require 'react'
{div} = React.DOM
TopMenu = require './topMenu'

PageBase = React.createClass
    displayName: "PageBase"

    propTypes:
        user: React.PropTypes.object

    render: ->
        div {className: "container"},
            TopMenu({user: @props.user})
            @props.children


module.exports = PageBase