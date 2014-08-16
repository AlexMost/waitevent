mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

eventSchema = Schema
    title: String
    description: String
    createdAt: {type: Date, default: Date.now}
    deadLine: {type: Date}
    userId: {type: ObjectId, ref: "User"}

UserEvent = mongoose.model("UserEvent", eventSchema)

module.exports = UserEvent