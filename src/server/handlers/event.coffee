moment = require 'moment'
CreateEventPage = require '../../components/create_event_page'
EventViewPage = require '../../components/event_view_page'
UserEvent = require '../models/userEvent'
{reactRender} = require '../react_render'


validate_ev_from_req = (req) ->
    req.checkBody('title', "Title param is required").notEmpty()
    req.checkBody('deadLine', "Select events date and time").isDate()
    req.validationErrors(true)


exports.event_view_get = (req, res) ->
    UserEvent.findOne({_id: req.params.eventId})
        .populate("participants")
        .exec (err, event) ->
            return res.send(404) unless event

            reactRender(
                res
                EventViewPage
                {user: req.user, event}
                {
                    initScript: '/js/event_view_page.js',
                    css: '/css/pages/event_view.css'
                }
            )


exports.create_event_get = (req, res) ->
    reactRender(
        res
        CreateEventPage
        {user: req.user}
        {initScript: '/js/create_event_page.js'}
    )


exports.create_event_post = (req, res) ->
    errors = validate_ev_from_req req

    if errors
        reactRender(
            res
            CreateEventPage
            {
                user: req.user
                errors: errors or {}
                formData: req.body
            }
            {initScript: '/js/create_event_page.js'}
        )
    else
        newEvent = new UserEvent
            title: req.body.title
            description: req.body.description
            deadLine: req.body.deadLine
            userId: req.user._id

        newEvent.participants.push req.user
        newEvent.save (err, event) ->
            # TODO: handle error
            res.redirect "/event/#{event._id}"


exports.edit_event_get = (req, res) ->
    UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
        return res.send(404) unless event

        reactRender(
            res
            CreateEventPage
            {edit: true, user: req.user, formData: event}
            {initScript: '/js/create_event_page.js'}
        )


exports.edit_event_post = (req, res) ->
    user = req.user
    UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
        return res.send(404) unless event
        return res.send(404) unless event.userId != user._id

        errors = validate_ev_from_req req

        if errors
            reactRender(
                res
                CreateEventPage
                    edit: true
                    user: req.user
                    errors: errors or {}
                    formData: req.body
                {initScript: '/js/create_event_page.js'}
            )
        else
            event.title = req.body.title
            event.description = req.body.description
            event.deadLine = req.body.deadLine

            event.save (err, event) ->
                # TODO: handle error
                res.redirect "/event/#{event._id}"


exports.delete_event = (req, res) ->
    user = req.user
    UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
        return res.send(404) unless event
        return res.send(404) unless event.userId != user._id
        event.status = 3
        event.save (err, event) ->
            res.json({status: "ok", action: "deleted", event: event})


exports.join_event = (req, res) ->
    user = req.user
    eventId = req.params.eventId
    UserEvent.findOne({_id: eventId})
        .populate("participants")
        .exec (err, event) ->
            return res.send(404) unless event

            participantIds = event.participants.map (p) ->
                p._id.toString()

            if user._id.toString() in participantIds
                return (res.send 403)

            event.participants.push user
            user.joinedEvents.push event

            event.save (err, event) ->
                user.save (err, user) ->
                    res.json({status: "ok", action: "joined", event})


exports.unjoin_event = (req, res) ->
    user = req.user
    eventId = req.params.eventId

    UserEvent.findOne({_id: eventId})
        .populate("participants")
        .exec (err, event) ->
            return res.send(404) unless event
            userId = user._id.toString()

            event.participants = event.participants.filter (p) ->
                p._id.toString() != userId
                
            user.joinedEvents = user.joinedEvents.filter (e) ->
                e.toString() != userId

            event.save (err, event) ->
                user.save (err, user) ->
                    res.json({status: "ok", action: "joined", event})

