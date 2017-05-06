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
        //
        // Clean up on exit
        //

        const win = nw.Window.get()

        win.on('closed', function() {
            Environments.cleanup()
        })


        // process.on('exit', () => {
        //     Environments.cleanup()
        // process.stdin.write('Here')

        // })

        // process.on('SIGINT', () => {
        //     Environments.cleanup()
        // process.stdin.write('Here 2')
        // })
    },
    components: {
        Sidebar
    }
}
</script>