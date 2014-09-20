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
        edit: false

    show: -> @refs.link_modal.show()

    add: ->
        @setState {edit: false}
        @show()

    edit: (key, link) ->
        @setState
            link_text: link.text
            url: link.url
            key: key
            edit: true
        @show()

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

                unless @state.edit
                    @props.onAddLink(
                        {
                            text: @state.link_text
                            url: @state.url
                        }
                    )
                else
                    @props.onEdit(
                        @state.key
                        text: @state.link_text
                        url: @state.url
                    )

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


LinkItem = React.createClass
    displayName: "LinkItem"

    render: ->
        div {},
            span {className: "h-mr-5 "}, @props.text
            a {href: @props.url}, @props.url
            span
                className:
                    "h-ml-5 h-pointer glyphicon glyphicon-pencil toolbar-icon"
                type: "button"
                onClick: @props.onEdit
            span
                className:
                    "h-ml-5 h-pointer glyphicon glyphicon-remove toolbar-icon"
                type: "button"
                onClick: @props.onDelete



AddLink = React.createClass
    displayName: "AddLink"

    getDefaultProps: ->
        links: []
        name: "links"

    getInitialState: ->
        links: @props.links

    deleteLink: (index) ->
        links = []
        for l, k in @state.links
            unless k is index
                links.push l
        @setState {links}

    editLink: (index, link) ->
        links = []
        for l, k in @state.links
            if k is index
                links.push link
            else
                links.push l
        @setState {links}


    render: ->
        div {},
            (for link, key in @state.links
                do (link, key) =>
                    LinkItem(
                        key: key
                        url: link.url
                        text: link.text
                        onDelete: =>
                            @deleteLink key
                        onEdit: =>
                            @refs.link_form.edit key, link
                    )
            )

            button
                type: "button"
                className: "btn btn-success btn-xs"
                onClick: => @refs.link_form.add()
                "+ link"

            AddLinkForm
                ref: "link_form"
                onAddLink: (link) =>
                    links = @state.links
                    links.push link
                    @setState {links}
                onEdit: @editLink

            input
                type: "hidden"
                value: JSON.stringify(@state.links)
                name: @props.name


module.exports = AddLink