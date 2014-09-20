Q = require 'q'
UserEvent = require '../models/userEvent'
{User, userView} = require '../models/user'

join_user_to_event = (user, eventId) ->
    """
    returns: Promise {user, event, participants}
    """

    deferred = Q.defer()

    UserEvent.findOne {_id: eventId}, (err, event) ->
        event_participant_ids = event.participants.map(
            (p) -> p.toString())

        unless user._id.toString() in event_participant_ids
            event.participants.push user
            user.joinedEvents.push event

        User.find {_id: {$in: event.participants}}, (err, raw_participants) ->
            participants = raw_participants.map userView
            if user._id.toString() in event_participant_ids
                return deferred.resolve {user, event, participants}
            event.save (err, event) ->
                deferred.reject(new Error err) if err
                user.save (err, user) ->
                    deferred.reject(new Error err) if err
                    deferred.resolve {user, event, participants}

    deferred.promise


get_event_view_context = (user, eventId) ->
    """
    returns: Promise {user, event, participants}
    """

    deferred = Q.defer()

    p_userEvent = UserEvent.findOne({_id: eventId}).exec()
    p_participants = p_userEvent.then(
        (event) -> User.find({_id: {$in: event.participants}}).exec())
    
    Q.spread([p_userEvent, p_participants], (user_event, raw_participants) ->
        participants = raw_participants.map userView
        deferred.resolve {user, event: user_event, participants}
    ).fail((error) ->
        deferred.reject(new Error error))

    return deferred.promise


module.exports = {join_user_to_event, get_event_view_context}