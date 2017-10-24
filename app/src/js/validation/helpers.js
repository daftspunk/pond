import Vue from 'vue'

function focusFirstField(errorBag) {
    const errorField = errorBag.getFirstErrorField()

    if (errorField) {
        Vue.nextTick(() => $('input[name='+errorField+'], textarea[name='+errorField+']').focus())
    }
}

export default {
    focusFirstField
}