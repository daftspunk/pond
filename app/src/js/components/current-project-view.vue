<template>
    <div class="flex-item current-project-view-panel">
        <div v-if="selectedProject">
            <div class="project-header">
                <div class="project-status" v-bind:class="{ online: selectedProject.metadata.online }"></div>
                <h3>{{ selectedProject.name }}</h3>
                <h4>{{ selectedClient.name }}</h4>

                <a class="settings-link">{{ $t('projects.settings_link') }}</a>
                <a class="star-indicator" v-on:click="toggleStar(selectedProject)" v-bind:class="{ starred: selectedProject.starred }"></a>
            </div>

            <div class="control-toolbar clearfix">
                <a class="btn btn-default" btn-icon="start" v-bind:disabled="selectedProject.metadata.online" href="#">{{ $t('projects.start') }}</a>
                <a class="btn btn-default" btn-icon="stop" v-bind:disabled="!selectedProject.metadata.online" href="#">{{ $t('projects.stop') }}</a>
                <a class="btn btn-primary pull-right" btn-icon="deploy" href="#">{{ $t('projects.deploy') }}</a>
            </div>
        </div>
        <div v-else class="no-project-selected">
            <div>
                <h3>{{ $t('projects.no_project_selected') }}</h3>
                <p>{{ $t('projects.select_project_or') }} <a href="#">{{ $t('projects.create_new_project') }}</a></p>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    computed: {
        selectedProject () {
            return this.$store.state.projects.selectedProject
        },
        selectedClient () {
            return this.$store.state.projects.selectedClient
        }
    },
    methods: {
        toggleStar (project) {
            this.$store.dispatch('toggleProjectStar', project)
        }
    }
}
</script>