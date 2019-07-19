<template>
    <div class="layout-full-size">
        <router-view></router-view>
    </div>
</template>

<script>
import environments from '../environments'

export default {
    mounted () {
        this.$store.dispatch('loadState').catch((error) => {
            throw error
        })

        //
        // Clean up on exit
        //

        require('electron').remote.app.on('before-quit', function() {
            environments.cleanup()
        })
    }
}
</script>
