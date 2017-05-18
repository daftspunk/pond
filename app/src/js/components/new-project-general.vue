<template>
    <div class="layout-full-size layout-flex-rows-container">
        <div class="layout-flex-row screen-header">
            <h3 class="no-subheader">{{ $t('projects.create_project.title') }}</h3>

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
                        <div class="col-sm-6">
                            <div class="input-field">
                                <input id="project-name" type="text" class="" v-focus="true">
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
                        <input id="project-description" type="text">
                        <label for="project-description">{{ $t('projects.create_project.description') }}</label>
                    </div>

                    <div class="standard-padding-bottom">
                        <div class="input-field directory-selector-container">
                            <input ref="directoryInput" type="file" webkitdirectory tabindex="-1" @change="directoryChanged"/>
                            <input v-model="directory" disabled type="text" id="directory-location" placeholder="Please select an empty directory">
                            <label ref="directoryLocationLabel" for="directory-location">{{ $t('projects.create_project.directory_location') }}</label>
                        </div>
                    </div>

                    <h4>{{ $t('projects.create_project.environment_type') }}</h4>

                    <div data-open-links-in-browser>
                        <input name="environment-type" type="radio" id="environment-pond" />
                        <label for="environment-pond">
                            {{ $t('projects.environment_type.pond') }}
                            <span class="description" v-html="$t('projects.create_project.pond_env_description')"></span>
                        </label>
                    </div>

                    <div data-open-links-in-browser>
                        <input name="environment-type" type="radio" id="environment-lamp" />
                        <label for="environment-lamp">
                            {{ $t('projects.environment_type.lamp') }}
                            <span class="description" v-html="$t('projects.create_project.lamp_env_description')"></span>
                        </label>
                    </div>

                    <div data-open-links-in-browser class="standard-padding-bottom">
                        <input name="environment-type" type="radio" id="environment-vagrant" />
                        <label for="environment-vagrant">
                            {{ $t('projects.environment_type.vagrant') }}
                            <span class="description" v-html="$t('projects.create_project.vagrant_env_description')"></span>
                        </label>
                    </div>

                    <button class="btn btn-primary">{{ $t('common.continue') }}</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import VueFocus from 'vue-focus'

export default {
    data () {
        return {
            directory: ''
        }
    },
    mixins: [
        VueFocus.mixin
    ],
    computed: {
    },
    methods: {
        directoryChanged () {
            if (this.$refs.directoryInput.value) {
                this.directory = this.$refs.directoryInput.value
            }

            this.$refs.directoryInput.value = ''
        }
    },
    components: {
    },
    mounted () {
        $(this.$refs.directoryLocationLabel).addClass('active')
    }
}
</script>