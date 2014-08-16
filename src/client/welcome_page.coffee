React = require 'react'
window.React = React
WelcomePageComponent = require '../components/welcome_page'
mountNode = document.getElementById "react-main-mount"
componentData = JSON.parse (document.getElementById "componentData").innerHTML

React.renderComponent(
    new WelcomePageComponent componentData
    mountNode
)

