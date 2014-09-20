React = require 'react'
{div, h1, a, form, script, input, button, span} = React.DOM
PageBase = require './portlets/base'
AddLink = require './portlets/add_link'
{HorizontalFormInputText, HorizontalFormTextArea,
HorizontalFormSubmit, HorizontalFormCustomField} = require './portlets/form'
{DateTimePicker} = require './portlets/datetime_picker'


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
            h1 {className: "text-center"}, "Enter some event data:"

            form {
                ref: "event_form"
                className: "form-horizontal", role: "form", method: "POST",
                onSubmit: =>
                    jdtp = $ "#datetimepicker_id"
                    jdtp.val new Date(jdtp.val()).toString()
                    @refs.event_form.getDOMNode().submit()
                },
                HorizontalFormInputText
                    key: "titleinput"
                    label: "Title"
                    name: "title"
                    value: @props.formData.title
                    error: @props.errors.title?.msg
                    placeholder: "Enter your event title"

                HorizontalFormCustomField
                    key: "links"
                    label: "Event links"
                    AddLink(
                        links: @props.formData.links
                        name: "links"
                    )

                HorizontalFormTextArea
                    key: "description"
                    label: "Description"
                    name: "description"
                    value: @props.formData.description
                    error: @props.errors.description?.msg
                    placeholder: "Enter some event description"

                DateTimePicker
                    key: "datetimepicker"
                    label: "Date time"
                    name: "deadLine"
                    value: deadLine
                    error: @props.errors.deadLine?.msg
                    placeholder: "Select event date time"

                HorizontalFormSubmit
                    key: "submitbtn"
                    text: submitButtonText

                input
                    type: "hidden"
                    name: "timezoneOffset"
                    value: (new Date(Date.now())).getTimezoneOffset()


module.exports = CreateEventPage