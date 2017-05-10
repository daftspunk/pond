<style lang="less" src="../../stylesheets/theme.less"></style>

<template>
    <div class="app-container">
        <sidebar></sidebar>

        <div class="flex-item main-view">
            <router-view></router-view>
        </div>
    </div>
</template>

<script>
import Sidebar from './sidebar.vue'
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
    },
    components: {
        Sidebar
    }
}
</script>