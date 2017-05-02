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
export default {
    // data () {
    //     return {
    //         msg: 'Hello world! :-)'
    //     }
    // }
    // ,
    components: {
        Sidebar
    }
}
</script>