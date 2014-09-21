mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId


EVENT_STATUSES =
    ACTIVE: 1
    CLOSED: 2
    DELETED: 3
    HIDDEN: 4


eventLinkSchema = Schema
    text: String
    url: String


eventSchema = Schema
    title: String
    description: String
    createdAt: {type: Date, default: Date.now}
    deadLine: {type: String}
    userId: {type: ObjectId, ref: "User"}
    status: {type: Number, default: EVENT_STATUSES.ACTIVE}
    participants: [{type: ObjectId, ref: "User"}]
    links: [eventLinkSchema]
    shareTwitter: {type: Boolean, default: false}
    shareFacebook: {type: Boolean, default: false}
    shareGoogle: {type: Boolean, default: false}


UserEvent = mongoose.model("UserEvent", eventSchema)


module.exports = UserEvent