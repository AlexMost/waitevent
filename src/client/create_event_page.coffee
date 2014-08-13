React = require 'react'
CreateEventPage = require '../components/create_event_page'
mountNode = document.getElementById "react-main-mount"
React.renderComponent new CreateEventPage, mountNode