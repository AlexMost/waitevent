mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

userSchema = Schema
    googleid: String
    googleProfile: Object
    joinedEvents: [{type: ObjectId, ref: "UserEvent"}]

User = mongoose.model("User", userSchema)


userView = (user) ->
    {
        id: user._id
        fullName: user.googleProfile._json.name
        name: user.googleProfile._json.given_name
        picture50: "#{user.googleProfile._json.picture}?sz=50"
        link: user.googleProfile._json.link
    }

module.exports = {User, userView}