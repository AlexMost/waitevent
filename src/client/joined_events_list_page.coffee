React = require 'react'
JoinedEventsListPage = require '../components/joined_events_list_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML


React.renderComponent(
    new JoinedEventsListPage componentData
    mountNode
)
