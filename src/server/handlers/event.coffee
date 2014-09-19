moment = require 'moment'
CreateEventPage = require '../../components/create_event_page'
EventViewPage = require '../../components/event_view_page'
UserEvent = require '../models/userEvent'
{User, userView} = require '../models/user'
{reactRender} = require '../react_render'
Q = require 'q'


validate_ev_from_req = (req) ->
    req.checkBody('title', "Title param is required").notEmpty()
    req.checkBody('deadLine', "Select events date and time").isDate()
    req.validationErrors(true)


exports.event_view_get = (req, res) ->
    p_userEvent = UserEvent.findOne({_id: req.params.eventId}).exec()
    p_participants = p_userEvent.then(
        (event) -> User.find({_id: {$in: event.participants}}).exec())
    
    Q.spread([p_userEvent, p_participants], (user_event, raw_participants) ->
        participants = raw_participants.map userView
        reactRender(
            res
            EventViewPage
            {user: req.user, event: user_event, participants}
            {
                initScript: '/js/event_view_page.js',
                css: '/css/pages/event_view.css'
            }
        )
    ).fail((error) ->
        console.log error.stack
        res.send(403).end()
    )


exports.create_event_get = (req, res) ->
    reactRender(
        res
        CreateEventPage
        {user: req.user}
        {
            initScript: '/js/create_event_page.js'
            css: '/css/pages/create_event.css'
        }
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
            {
                initScript: '/js/create_event_page.js'
                css: '/css/pages/create_event.css'
            }
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
            {
                initScript: '/js/create_event_page.js'
                css: '/css/pages/create_event.css'
            }
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
                {
                    initScript: '/js/create_event_page.js'
                    css: '/css/pages/create_event.css'
                }
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

    UserEvent.findOne {_id: eventId}, (err, event) ->
        if user._id.toString() in (event.participants.map (p) -> p.toString())
            return (res.send 403)

        event.participants.push user
        user.joinedEvents.push event

        User.find {_id: {$in: event.participants}}, (err, raw_participants) ->
            participants = raw_participants.map userView

            event.save (err, event) ->
                user.save (err, user) ->
                    res.json(
                        {
                            status: "ok"
                            action: "joined"
                            event
                            participants
                        })


exports.unjoin_event = (req, res) ->
    user = req.user
    eventId = req.params.eventId

    p_user_event = UserEvent.findOne({_id: eventId}).exec()
    p_participants = p_user_event.then(
        (event) -> User.find(
            {_id: {$in: event.participants}}).exec())

    Q.spread([p_user_event, p_participants], (event, raw_participants) ->
        participants = raw_participants
            .filter((p) -> p._id.toString() != user._id.toString())
            .map(userView)

        user.joinedEvents = user.joinedEvents.filter (e) ->
            e.toString() != event._id.toString()

        event.participants = event.participants.filter (p) ->
            p.toString() != user._id.toString()

        event.save (err, event) ->
            user.save (err, user) ->
                res.json(
                    {status: "ok", action: "joined", event, participants})
    ).fail((err) ->
        console.log err.stack
        res.send(403).end()
    )

