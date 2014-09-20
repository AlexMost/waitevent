React = require 'react'
EventViewPage = require '../components/event_view_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML
transport = require './transport'


init = ->
    componentData.currentUrl = document.URL
    
    componentData.onJoinEvent = (event) ->
        transport.join_event component.props.event, (err, result) ->
            return if err

            newProps =
                event: result.event

            if result.participants
                newProps.participants = result.participants

            component.setProps newProps

    componentData.onUnjoinEvent = (event) ->
        transport.unjoin_event component.props.event, (err, result) ->
            return if err
            newProps =
                event: result.event

            if result.participants
                newProps.participants = result.participants

            component.setProps newProps

    component = React.renderComponent(
        new EventViewPage componentData
        mountNode
    )

init()