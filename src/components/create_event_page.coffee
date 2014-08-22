React = require 'react'
{div, h1, a, form, script} = React.DOM
PageBase = require './portlets/base'
{HorizontalFormInputText, HorizontalFormTextArea,
HorizontalFormSubmit} = require './portlets/form'
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

            form {className: "form-horizontal", role: "form", method: "POST"},
                HorizontalFormInputText
                    key: "titleinput"
                    label: "Title"
                    name: "title"
                    value: @props.formData.title
                    error: @props.errors.title?.msg
                    placeholder: "Enter your event title"

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


module.exports = CreateEventPage