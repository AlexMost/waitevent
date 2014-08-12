React = require 'react'
WelcomePageComponent = require '../components/welcome_page'
mountNode = document.getElementById "react-main-mount"
React.renderComponent new WelcomePageComponent, mountNode

