<template>
    <div class="app-container">
        <sidebar></sidebar>

        <div class="project-view-container main-view flex-item">
            <projects-side-panel></projects-side-panel>
            <current-project-view></current-project-view>
        </div>
    </div>
</template>

<script>
import Sidebar from './sidebar.vue'
import ProjectsSidePanel from './projects-side-panel.vue'
import CurrentProjectView from './current-project-view.vue'
export default {
    components: {
        ProjectsSidePanel,
        CurrentProjectView,
        Sidebar
    }
}
</script>