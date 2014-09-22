UserEvent = require '../models/userEvent'


get_users_created_events = (userId) ->
    UserEvent
    .find({userId, status: 1})
    .sort("-createdAt")
    .exec()


get_users_participated_events = (eventIds) ->
    UserEvent
    .find()
    .where('_id').in(eventIds)
    .sort("createdAt")
    .exec()


module.exports = {get_users_created_events, get_users_participated_events}
