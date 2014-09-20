React = require 'react'
{div, a, img} = React.DOM
Modal = require './modal'

AuthPopup = React.createClass
    displayName: "AuthPopup"

    getDefaultProps: ->
        callbackUrl: ""

    show: ->
        @refs.modal.show()

    render: ->
        Modal(
            ref: "modal"
            title: "Sign in:"
            skipButtons: true
            width: "300px"
            div {className: "text-center"},
                a {href: "/auth/google?r=#{@props.callbackUrl}"},
                    img
                        width: "200px"
                        src: "/img/sign-in-with-google.png"
        )

module.exports = {AuthPopup}
