mongoose = require 'mongoose'
Schema = mongoose.Schema

eventSchema = Schema
    title: String
    _userId: {type: Number, ref: "User"}

UserEvent = mongoose.model("UserEvent", eventSchema)

module.exports = UserEvent