<template>
    <div class="project-view-container">
        <projects-side-panel></projects-side-panel>
        <current-project-view></current-project-view>
    </div>
</template>

<script>
import ProjectsSidePanel from './projects-side-panel.vue'
import CurrentProjectView from './current-project-view.vue'
export default {
    components: {
        ProjectsSidePanel,
        CurrentProjectView
    }
}
</script>