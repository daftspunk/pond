<template>
    <div class="flex-item projects-side-panel">
        <project-list></project-list>
    </div>
</template>

<script>
import ProjectList from "./project-list.vue"
export default {
    components: {
        ProjectList
    }
}
</script>