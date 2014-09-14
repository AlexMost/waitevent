exports.delete_event = (event, cb) ->
    $.ajax(
        type: "POST"
        url: "/delete_event/#{@state.delItem._id}"
        success: (data) -> cb null, data
        error: (data) -> cb data
        )


exports.join_event = (event, cb) ->
    $.ajax(
        type: "POST"
        url: "/join_event/#{event._id}"
        success: (data) -> cb null, data
        error: (data) -> cb data
    )


exports.unjoin_event = (event, cb) ->
    $.ajax(
        type: "POST"
        url: "/unjoin_event/#{event._id}"
        success: (data) -> cb null, data
        error: (data) -> cb data
    )