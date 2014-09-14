mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

userSchema = Schema
    googleid: String
    googleProfile: Object
    joinedEvents: [{type: ObjectId, ref: "UserEvent"}]

User = mongoose.model("User", userSchema)

module.exports = User