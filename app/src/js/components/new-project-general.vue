<template>
    <div class="layout-flex-rows-container">
        <div class="layout-flex-row screen-header">
            <h3 class="no-subheader">{{ $t('projects.create_project.title') }}</h3>

            <span class="header-icon close-screen-router-link">
                <router-link tag="span" to="/">
                    <a class="close-screen-link">{{ $t('common.close') }}</a>
                </router-link>
            </span>
        </div>

        <div class="layout-flex-row layout-stretch">
            <div class="standard-panel-paddings standard-padding-bottom standard-padding-top">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="input-field">
                            <input id="project-name" type="text" class="">
                            <label for="project-name">{{ $t('projects.create_project.project_name') }}</label>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="input-field">
                            <input id="client-name" type="text" class="">
                            <label for="client-name">{{ $t('projects.create_project.client_name') }}</label>
                        </div>
                    </div>
                </div>

                <div class="input-field">
                    <textarea id="project-description" class="materialize-textarea"></textarea>
                    <label for="project-description">{{ $t('projects.create_project.description') }}</label>
                </div>

            </div>
        </div>
    </div>
</template>

<script>
export default {
    computed: {
    },
    methods: {
    },
    components: {
    }
}
</script>