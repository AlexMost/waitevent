has_parent = (node, leaf) ->
    while leaf isnt document
        if node is leaf
            return true
        leaf = leaf.parentNode
    false

module.exports = {has_parent}
