React = require 'react'
JoinedEventsListPage = require '../components/joined_events_list_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML
transport = require './transport'

init = () ->
    componentData.onUnjoinEvent = (event) ->
        transport.unjoin_event event, (err, result) ->
            events = component.props.events.filter (e) ->
                e._id isnt result.event._id
            component.setProps {events, user: result.user}

    component = React.renderComponent(
        new JoinedEventsListPage componentData
        mountNode
    )

init()
