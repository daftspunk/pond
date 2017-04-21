<template>
    <div class="projects-side-panel-search">
        <input type="text" class="form-control" v-model="filterString" :placeholder="$t('projects.find_placeholder')">
    </div>
</template>

<script>
export default {
    getters: {
        filterString: state => state.projects.listFilterString
    }
}
</script>