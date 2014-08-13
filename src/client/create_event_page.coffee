React = require 'react'
CreateEventPage = require '../components/create_event_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML

React.renderComponent(
    new CreateEventPage componentData
    mountNode
)