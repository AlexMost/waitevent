mongoose = require 'mongoose'
Schema = mongoose.Schema
userSchema = Schema
    name: String

User = mongoose.model("User", userSchema)

module.exports = User