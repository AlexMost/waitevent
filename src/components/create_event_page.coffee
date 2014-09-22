React = require 'react'
{div, h1, h2, a, form, script, input, button, span} = React.DOM
PageBase = require './portlets/base'
AddLink = require './portlets/add_link'
{HorizontalFormInputText, HorizontalFormTextArea,
HorizontalFormSubmit, HorizontalFormCustomField} = require './portlets/form'
{DateTimePicker} = require './portlets/datetime_picker'
{SocialShareFormField} = require './portlets/social_form_field'


CreateEventPage = React.createClass
    displayName: "CreateEventPage"

    propTypes:
        user: React.PropTypes.object
        errors: React.PropTypes.object
        formData: React.PropTypes.object
        edit: React.PropTypes.bool


    getDefaultProps: ->
        errors: {}
        formData: {}
        edit: false


    render: ->

        deadLine = (if @props.formData.deadLine
            new Date @props.formData.deadLine
        else
            d = new Date Date.now()
            d.setHours(d.getHours() + 1)
            d
        ).toLocaleString()

        submitButtonText = if @props.edit
            "Edit event"
        else
            "Create event"

        PageBase {user: @props.user},
            h1
                className: "text-center"
                style: {"margin-bottom": "5%"}
                "Enter some event data:"

            form
                ref: "event_form"
                className: "form-horizontal"
                role: "form"
                method: "POST"
                onSubmit: =>
                    jdtp = $ "#datetimepicker_id"
                    $(@refs.deadLine.getDOMNode()).val(
                        new Date(jdtp.val()).toString())
                    @refs.event_form.getDOMNode().submit()
                div {className: "panel panel-default box-shadow"},

                    div {className: "panel-heading"},
                        h2 {className: "panel-title"}, "Event info"

                    div {className: "panel-body h-mt-20"},

                        HorizontalFormInputText
                            key: "titleinput"
                            label: "Title"
                            name: "title"
                            value: @props.formData.title
                            error: @props.errors.title?.msg
                            placeholder: "Enter your event title"

                        DateTimePicker
                            key: "datetimepicker"
                            label: "Date time"
                            name: "deadLine_fake"
                            value: deadLine
                            error: @props.errors.deadLine?.msg
                            placeholder: "Select event date time"

                        input
                            ref: "deadLine"
                            type: "hidden"
                            name: "deadLine"
                            defaultValue: deadLine

                        HorizontalFormTextArea
                            key: "description"
                            label: "Description"
                            name: "description"
                            value: @props.formData.description
                            error: @props.errors.description?.msg
                            placeholder: "Enter some event description"

                        HorizontalFormCustomField
                            key: "links"
                            label: "Event links"
                            AddLink(
                                links: @props.formData.links
                                name: "links"
                            )

                        HorizontalFormCustomField
                            key: "social"
                            label: "Social share buttons"
                            SocialShareFormField(
                                shareTwitter: @props.formData.shareTwitter
                                shareFacebook: @props.formData.shareFacebook
                                shareGoogle: @props.formData.shareGoogle
                            )

                HorizontalFormSubmit
                    key: "submitbtn"
                    text: submitButtonText


module.exports = CreateEventPage