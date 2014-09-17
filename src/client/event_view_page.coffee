React = require 'react'
EventViewPage = require '../components/event_view_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML
transport = require './transport'


init = ->
    componentData.onJoinEvent = (event) ->
        transport.join_event component.props.event, (err, result) ->
            unless err
                component.setProps {
                    event: result.event
                    participants: result.participants
                }

    componentData.onUnjoinEvent = (event) ->
        transport.unjoin_event component.props.event, (err, result) ->
            unless err
                component.setProps {
                    event: result.event
                    participants: result.participants
                }

    component = React.renderComponent(
        new EventViewPage componentData
        mountNode
    )

init()