React = require 'react'


reactRender = (res, componentClass, props, templateProps) ->
    component = new componentClass props
    str = React.renderComponentToString component
    templateProps['reactOutput'] = str
    res.render('layout', templateProps)


module.exports = {reactRender}