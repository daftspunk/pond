<template>
    <div class="log-panel layout-full-size layout-flex-rows-container">
        <div class="controls layout-flex-row">
            <a class="refresh" href="#" v-bind:title="$t('projects.refresh')">{{ $t('projects.refresh') }}</a>
            <a class="clear" href="#" v-bind:title="$t('projects.clear')">{{ $t('projects.clear') }}</a>
        </div>
        <div class="text-viewer layout-flex-row layout-stretch" id="editor1"></div>
    </div>
</template>

<script>
import Brace from 'brace'

export default {
    mounted () {
        var editor = Brace.edit($(this.$el).find(".text-viewer").get(0))
        editor.setReadOnly(true)
        editor.setShowPrintMargin(false)
        editor.setHighlightActiveLine(false)
        editor.container.style.lineHeight = 2
        editor.renderer.updateFontSize()
    }
}
</script>