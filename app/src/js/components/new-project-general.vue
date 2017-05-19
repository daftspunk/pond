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

        <form class="layout-flex-row layout-stretch layout-relative" @submit.prevent="goNextStep">
            <div class="layout-full-size scrollable">
                <div class="standard-panel-paddings standard-padding-bottom standard-padding-top">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="input-field">
                                <input
                                    id="project-name"
                                    type="text"
                                    v-model="project.name"
                                    class="validation"
                                    v-bind:class="{ invalid: errorBag.has('name') }">
                                <label for="project-name">{{ $t('projects.create_project.project_name') }}</label>
                                <span class="validation-error">{{ $t(errorBag.get('name')) }}</span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-field">
                                <input
                                    id="client-name"
                                    type="text"
                                    v-model="project.client"
                                    class="validation"
                                    v-bind:class="{ invalid: errorBag.has('client') }">
                                <label for="client-name">{{ $t('projects.create_project.client_name') }}</label>
                                <span class="validation-error">{{ $t(errorBag.get('client')) }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="input-field">
                        <input id="project-description" type="text" v-model="project.description">
                        <label for="project-description">{{ $t('projects.create_project.description') }}</label>
                    </div>

                    <div class="standard-padding-bottom">
                        <div class="input-field">
                            <input disabled type="text" v-model="project.location" id="directory-location" placeholder="Please select an empty directory">
                            <label ref="directoryLocationLabel" for="directory-location">{{ $t('projects.create_project.directory_location') }}</label>
                        </div>
                    </div>

                    <h4 v-bind:class="{ invalid: errorBag.has('environmentType') }">
                        {{ $t('projects.create_project.environment_type') }}
                    </h4>
                    <span class="validation-error">{{ $t(errorBag.get('environmentType')) }}</span>

                    <div data-open-links-in-browser>
                        <input
                            name="environment-type" value="pond" type="radio" id="environment-pond" v-model="project.environmentType"/>
                        <label for="environment-pond">
                            {{ $t('projects.environment_type.pond') }}
                            <span class="description" v-html="$t('projects.create_project.pond_env_description')"></span>
                        </label>
                    </div>

                    <div data-open-links-in-browser>
                        <input name="environment-type" value="lamp" type="radio" id="environment-lamp" v-model="project.environmentType"/>
                        <label for="environment-lamp">
                            {{ $t('projects.environment_type.lamp') }}
                            <span class="description" v-html="$t('projects.create_project.lamp_env_description')"></span>
                        </label>
                    </div>

                    <div data-open-links-in-browser class="standard-padding-bottom">
                        <input name="environment-type" value="vagrant" type="radio" id="environment-vagrant" v-model="project.environmentType"/>
                        <label for="environment-vagrant">
                            {{ $t('projects.environment_type.vagrant') }}
                            <span class="description" v-html="$t('projects.create_project.vagrant_env_description')"></span>
                        </label>
                    </div>

                    <input type="submit" class="btn btn-primary" v-bind:value="$t('common.continue')">
                </div>
            </div>
        </form>
    </div>
</template>

<script>
import VueFocus from 'vue-focus'
import ErrorBag from '../validation/error-bag'
import PreValidator from '../environments/project-prevalidator'

export default {
    data () {
        return {
            errorBag: new ErrorBag()
        }
    },
    mixins: [
        VueFocus.mixin
    ],
    computed: {
        project () {
            return this.$store.state.projects.newProject
        }
    },
    methods: {
        goNextStep () {
            const validator = new PreValidator()
            this.errorBag.cleanup()
            validator.validate(this.project, this.errorBag)
        }
    },
    mounted () {
        $(this.$refs.directoryLocationLabel).addClass('active')
        this.errorBag.cleanup()
    }
}
</script>