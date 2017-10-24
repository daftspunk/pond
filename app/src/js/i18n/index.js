import VueI18n from 'vue-i18n'
import Messages from './messages'

export default {
    getVueI18n: () => VueI18n,
    makeI18n: () => new VueI18n({
        locale: 'en',
        messages: Messages
    })
}