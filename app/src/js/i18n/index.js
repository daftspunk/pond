const VueI18n = require('vue-i18n')
const Messages = require('./messages')

module.exports = {
    getVueI18n: () => VueI18n,
    makeI18n: () => new VueI18n({
        locale: 'en',
        messages: Messages
    })
}