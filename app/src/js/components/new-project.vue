<template>
    <div class="new-project-host layout-full-size layout-flex-rows-container">
        <new-project-general-information></new-project-general-information>
    </div>
</template>

<script>
import NewProjectGeneralInformation from './new-project-general.vue'

export default {
    components: {
        NewProjectGeneralInformation
    },
    mounted () {
        // TODO - commit a mutation for setting the newProject state property.
        // If it's a first project - prepopulate with demo data,
        // see #6
    }
}
</script>