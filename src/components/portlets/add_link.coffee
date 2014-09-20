React = require 'react'
{div, h1, a, form, script, input, button, span, label} = React.DOM
Modal = require './modal'


AddLinkForm = React.createClass
    displayName: "AddLinkForm"

    getInitialState: ->
        link_text: @props.text
        url: @props.url
        link_text_empty: false
        url_empty: false

    show: -> @refs.link_modal.show()

    render: ->
        link_text_cls = if @state.link_text_empty
            "has-error"
        else
            ""

        url_cls = if @state.url_empty
            "has-error"
        else
            ""

        Modal(
            ref: "link_modal"
            title: "Link info:"
            onConfirm: (ev) =>
                @setState
                    link_text: ""
                    url: ""
                    link_text_empty: false
                    url_empty: false

                @props.onAddLink(
                    {text: @state.link_text, url: @state.url})

            confirmPredicate: =>
                @setState
                    link_text_empty: ! @state.link_text
                    url_empty: ! @state.url

                @state.link_text and @state.url

            div {className: "link-add-form text-center form-inline"},
                div
                    className: "form-group #{link_text_cls}"
                    key: "link_text"

                    label {className: "sr-only"}, ""
                    input
                        type: "text"
                        className: "form-control"
                        placeholder: "Link text"
                        value: @state.link_text
                        onChange: (ev) =>
                            @setState {link_text: ev.target.value}

                div {className: "form-group #{url_cls}", key: "url"},
                    label {className: "sr-only", htmlFor: "link_text"}, ""
                    input
                        id: "link_text"
                        type: "text"
                        placeholder: "URL"
                        className: "form-control"
                        value: @state.url
                        onChange: (ev) =>
                            @setState {url: ev.target.value}
        )


AddLink = React.createClass
    displayName: "AddLink"

    getDefaultProps: ->
        links: []
        name: "links"

    getInitialState: ->
        links: @props.links

    render: ->
        div {},
            (for link, key in @state.links
                div {key},
                    span {className: "h-mr-5 "}, link.text
                    a {href: link.url}, link.url)
            button
                type: "button"
                className: "btn btn-success btn-xs"
                onClick: => @refs.link_form.show()
                "+ link"

            AddLinkForm
                ref: "link_form"
                onAddLink: (link) =>
                    links = @state.links
                    links.push link
                    @setState {links}

            input
                type: "hidden"
                value: JSON.stringify(@state.links)
                name: @props.name

module.exports = AddLink