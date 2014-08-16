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

    render: ->
        PageBase {user: @props.user},
            h1 {className: "text-center"}, "Enter some event data:"

            form {className: "form-horizontal", role: "form", method: "POST"},
                HorizontalFormInputText
                    key: "titleinput"
                    label: "Title"
                    name: "title"
                    placeholder: "Enter your event title"

                HorizontalFormTextArea
                    key: "description"
                    label: "Description"
                    name: "description"
                    placeholder: "Enter some event description"

                DateTimePicker
                    key: "datetimepicker"
                    label: "Date time"
                    name: "datetime"
                    placeholder: "Select event date time"

                HorizontalFormSubmit
                    key: "submitbtn"
                    text: "Create event!"


module.exports = CreateEventPage