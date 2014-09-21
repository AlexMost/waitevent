React = require 'react'
{div, input, label} = React.DOM


SocialShareFormField = React.createClass
    displayName: "SocialShareFormField"


    propTypes:
        shareTwitter: React.PropTypes.bool
        shareFacebook: React.PropTypes.bool
        shareGoogle: React.PropTypes.bool


    getInitialState: ->
        shareTwitter: @props.shareTwitter
        shareFacebook: @props.shareFacebook
        shareGoogle: @props.shareGoogle


    render: ->
        div {},
            div {className: "checkbox"},
                label {},
                    input
                        type: "checkbox"
                        name: "shareTwitter"
                        checked: @state.shareTwitter
                        onChange: (ev) =>
                            @setState {shareTwitter: ev.target.checked}
                        "twitter"

            div {className: "checkbox"},
                label {},
                    input
                        type: "checkbox"
                        name: "shareFacebook"
                        checked: @state.shareFacebook
                        onChange: (ev) =>
                            @setState {shareFacebook: ev.target.checked}
                        "facebook"

            div {className: "checkbox"},
                label {},
                    input
                        type: "checkbox"
                        name: "shareGoogle"
                        checked: @state.shareGoogle
                        onChange: (ev) =>
                            @setState {shareGoogle: ev.target.checked}
                        "google"


module.exports = {SocialShareFormField}