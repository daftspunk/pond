<template>
    <div class="new-project-host layout-full-size layout-flex-rows-container">
        <general-information
            v-if="stepCode == 'general'"
            @show-env-config-step="showEnvironmentConfigurationStep"
        ></general-information>

        <pond-configuration
            v-if="stepCode == 'env-config' && project.environmentType == 'pond'"
            @show-provisioning-step="showProvisioningStep"
            @show-general-step="showGeneralStep"
        ></pond-configuration>

        <provisioning
            v-if="stepCode == 'provisioning'"
            @show-env-config-step="showEnvironmentConfigurationStep"
            @show-done-step="showDoneStep"
        ></provisioning>

        <done
            v-if="stepCode == 'done'"
        ></done>
    </div>
</template>

<script>
import GeneralInformation from './general.vue'
import PondConfiguration from './pond-configuration.vue'
import Provisioning from './provisioning.vue'
import Done from './done.vue'

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
        PondConfiguration,
        Provisioning,
        Done
    },
    methods: {
        showEnvironmentConfigurationStep () {
            this.stepCode = 'env-config'
        },
        showGeneralStep () {
            this.stepCode = 'general'
        },
        showProvisioningStep () {
            this.stepCode = 'provisioning'
        },
        showDoneStep () {
            this.stepCode = 'done'
        }
    },
    mounted () {
        if (!this.$store.state.projects.list.length) {
            this.$store.dispatch('initNewProjectState', {isDemo: true})
        }
        else {
            this.$store.dispatch('initNewProjectState')
        }
    }
}
</script>