UserEvent = require '../models/userEvent'
MyEventsListPage = require '../../components/my_events_list_page'
JoinedEventsListPage = require '../../components/joined_events_list_page'
{reactRender} = require '../react_render'
{get_users_created_events,
get_users_participated_events} = require '../bl/bl_event_list'


exports.my_events_get = (req, res) ->
    get_users_created_events(req.user.id).then(
        (events) ->
            reactRender(
                res
                MyEventsListPage
                {user: req.user, events}
                {
                    initScript: './js/my_events_list_page.js'
                    css: './css/pages/my_events_list.css'
                    title: "Events list"
                }
            )
    )

exports.participated_events = (req, res) ->
    get_users_participated_events(req.user.joinedEvents).then(
        (events) ->
            reactRender(
                res
                JoinedEventsListPage
                {user: req.user, events}
                {
                    initScript: './js/joined_events_list_page.js'
                    css: './css/pages/my_events_list.css'
                    title: "Joined events list"
                }
            )
    )

