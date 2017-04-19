var VueI18n = require('vue-i18n')
var Messages = require('./messages')

module.exports = {
    vueI18n: VueI18n,
    // i18n: i18n
    makeI18n: () => new VueI18n({
        locale: 'en',
        messages: Messages
    })
}