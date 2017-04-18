<style lang="less" src="../../stylesheets/main.less"></style>

<template>
    <div>
        <p>Root component</p>

        <p>
            <router-link to="/">Index</router-link>
            <router-link to="/settings">Settings</router-link>
        </p>

        <router-view></router-view>
    </div>
</template>

<script>
export default {
    // data () {
    //     return {
    //         msg: 'Hello world! :-)'
    //     }
    // }
    // ,
    components: {
        // RouterLink,
        // RouterView
    }
}
</script>