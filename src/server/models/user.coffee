mongoose = require 'mongoose'
Schema = mongoose.Schema
userSchema = Schema
    googleid: String
    googleProfile: Object

User = mongoose.model("User", userSchema)

module.exports = User