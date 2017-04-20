<template>
    <div class="flex-item projects-side-panel">
        <projects-side-panel-search></projects-side-panel-search>
        <project-list></project-list>
    </div>
</template>

<script>
import ProjectsSidePanelSearch from "./projects-side-panel-search.vue"
import ProjectList from "./project-list.vue"
export default {
    components: {
        ProjectsSidePanelSearch,
        ProjectList
    }
}
</script>