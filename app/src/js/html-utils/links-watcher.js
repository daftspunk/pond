// const Nw = require('nw')

function handleLinkClick(ev) {
    var link = jQuery(ev.currentTarget)

    if (link.closest('[data-open-links-in-browser]').length === 0) {
        return
    }

    ev.preventDefault()
    ev.stopPropagation()

    var href = link.attr('href')

    if (!/^https?|ftps?|mailto:\/\//.test(href)) {
        return
    }

    nw.Shell.openExternal(href)
}

jQuery(document).on('click', 'a', handleLinkClick)

module.exports = {
    
}