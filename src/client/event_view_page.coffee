React = require 'react'
window.React = React
EventViewPage = require '../components/event_view_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML


React.renderComponent(
    new EventViewPage componentData
    mountNode
)