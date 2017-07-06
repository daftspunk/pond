<template>
    <div class="layout-full-size layout-flex-rows-container">
        <div class="layout-flex-row screen-header">
            <h3>{{ $t('projects.create_project.title') }}</h3>
            <h4>{{ $t('projects.create_project.done') }}</h4>

            <span class="header-icon close-screen-router-link">
                <router-link tag="span" to="/">
                    <a class="close-screen-link">{{ $t('common.close') }}</a>
                </router-link>
            </span>
        </div>

        <div class="layout-flex-row layout-stretch layout-relative">
            <div class="layout-full-size scrollable">
                <div class="standard-panel-paddings standard-padding-bottom standard-padding-top">
                    <div class="row">
                        <div class="col-sm-10 col-sm-offset-1">
                            <h3 class="double-padding-top new-project-done-badge">{{ $t('projects.create_project.project_ready') }}</h3>

                            <p class="double-padding-top">
                                {{ $t('projects.create_project.done_notice') }}
                            </p>

                            <div class="notice info" v-if="!project.useAdvancedOptions">
                                <p>
                                    {{ $t('projects.create_project.default_admin_credentials') }}
                                </p>
                            </div>

                            <p>
                                <a class="btn btn-primary" @click.stop.prevent="goToProject">{{ $t('projects.create_project.go_to_project') }}</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data () {
        return {
        }
    },
    computed: {
        project () {
            return this.$store.state.projects.newProject
        }
    },
    methods: {
        goToProject () {
            this.$router.push('/')
        }
    },
    mounted () {

    }
}
</script>