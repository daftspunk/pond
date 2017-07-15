<style lang="less" src="../../stylesheets/theme.less"></style>

<template>
    <div class="layout-full-size">
        <router-view></router-view>
    </div>
</template>

<script>
import Environments from '../environments'

export default {
    mounted () {
        this.$store.dispatch('loadState').catch((error) => {
            throw error
        })

        //
        // Clean up on exit
        //

        const win = nw.Window.get()

        win.on('closed', function() {
            Environments.cleanup()
        })
    }
}
</script>