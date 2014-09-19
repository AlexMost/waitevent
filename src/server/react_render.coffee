React = require 'react'

sanitizeOutputJson = (raw_json) ->
    raw_json.replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")


reactRender = (res, componentClass, props, templateProps) ->
    component = new componentClass props
    str = React.renderComponentToString component
    templateProps['reactOutput'] = str
    # templateProps['componentData'] =
    #     sanitizeOutputJson(JSON.stringify props)
    templateProps['componentData'] = JSON.stringify props
    res.render('layout', templateProps)


module.exports = {reactRender}