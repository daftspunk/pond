<template>
    <div class="new-project-host layout-full-size layout-flex-rows-container">
        <general-information
            v-if="stepCode == 'general'"
            @show-env-config-step="showEnvironmentConfigurationStep"
        ></general-information>

        <pond-configuration
            v-if="stepCode == 'env-config' && project.environmentType == 'pond'"
            @show-progress-step="showProgressStep"
            @show-general-step="showGeneralStep"
        ></pond-configuration>
    </div>
</template>

<script>
import GeneralInformation from './general.vue'
import PondConfiguration from './pond-configuration.vue'

export default {
    data () {
        return {
            stepCode: 'general'
        }
    },
    computed: {
        project () {
            return this.$store.state.projects.newProject
        }
    },
    components: {
        GeneralInformation,
        PondConfiguration
    },
    methods: {
        showEnvironmentConfigurationStep () {
            this.stepCode = 'env-config'
        },
        showGeneralStep () {
            this.stepCode = 'general'
        },
        showProgressStep () {
            
        }
    },
    mounted () {
        // TODO - commit a mutation for setting the newProject state property.
        // If it's a first project - prepopulate with demo data,
        // see #6
    }
}
</script>