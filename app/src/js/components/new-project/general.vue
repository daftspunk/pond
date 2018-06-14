<template>
    <div class="layout-full-size layout-flex-rows-container">
        <div class="layout-flex-row screen-header">
            <h3>{{ $t('projects.create_project.title') }}</h3>
            <h4>{{ $t('projects.create_project.general_information') }}</h4>

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
                            <div class="form-group required">
                                <label for="project-name">{{ $t('projects.create_project.project_name') }}</label>
                                <input
                                    id="project-name"
                                    type="text"
                                    v-model="project.name"
                                    class="form-control"
                                    ref="nameInput"
                                    name="name"
                                    v-bind:class="{ invalid: errorBag.has('name') }">
                                <span class="validation-error">{{ $t(errorBag.get('name')) }}</span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group required">
                                <label for="client-name">{{ $t('projects.create_project.client_name') }}</label>
                                <input
                                    id="client-name"
                                    type="text"
                                    v-model="project.client"
                                    class="form-control"
                                    name="client"
                                    v-bind:class="{ invalid: errorBag.has('client') }">
                                <span class="validation-error">{{ $t(errorBag.get('client')) }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group required">
                        <label ref="directoryLocationLabel" for="directory-location">{{ $t('projects.create_project.directory_location') }}</label>
                        <div class="input-control directory-selector" @click="onDirectoryClick">
                            <input
                                ref="directoryInput"
                                type="file"
                                webkitdirectory="" directory=""
                                @change="directoryChanged($event)"
                                v-bind:class="{ invalid: errorBag.has('location') }"
                            />
                            <directory-location
                                v-bind:location="project.location"
                                placeholder="projects.create_project.location_placeholder"
                            ></directory-location>
                            <span class="validation-error">{{ $t(errorBag.get('location')) }}</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label v-bind:class="{active: project.description}" for="project-description">{{ $t('projects.create_project.description') }}</label>
                        <textarea id="project-description" class="form-control" type="text" v-bind:placeholder="$t('projects.create_project.description_placeholder')" v-model="project.description"></textarea>
                    </div>

                    <h4 v-bind:class="{ invalid: errorBag.has('environmentType') }">
                        {{ $t('projects.create_project.environment_type') }}
                    </h4>
                    <span class="validation-error">{{ $t(errorBag.get('environmentType')) }}</span>

                    <div class="form-group">
                        <div data-open-links-in-browser class="radio">
                            <label for="environment-pond">
                                <input
                                    name="environment-type" value="pond" type="radio" id="environment-pond" v-model="project.environmentType"/>
                                <span class="radio-label">{{ $t('projects.environment_type.pond') }}</span>
                                <span class="description" v-html="$t('projects.create_project.pond_env_description', {phpVersion: phpVersion})"></span>
                            </label>
                        </div>

                        <div data-open-links-in-browser class="radio">
                            <label for="environment-lamp">
                                <input name="environment-type" value="lamp" type="radio" id="environment-lamp" v-model="project.environmentType"/>
                                <span class="radio-label">{{ $t('projects.environment_type.lamp') }}</span>
                                <span class="description" v-html="$t('projects.create_project.lamp_env_description')"></span>
                            </label>
                        </div>

                        <div data-open-links-in-browser class="radio">
                            <label for="environment-vagrant">
                                <input name="environment-type" value="vagrant" type="radio" id="environment-vagrant" v-model="project.environmentType"/>
                                <span class="radio-label">{{ $t('projects.environment_type.vagrant') }}</span>
                                <span class="description" v-html="$t('projects.create_project.vagrant_env_description')"></span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="toggle">
                            <label>
                                <input
                                    name="use-advanced-options"
                                    value="1"
                                    type="checkbox"
                                    @click="onUseAdvancedOptionsClick"
                                    ref="useAdvancedOptions"/>
                                <span class="toggle-label">{{ $t('projects.create_project.show_advanced_options') }}</span>
                            </label>
                        </div>
                    </div>

                    <div v-show="useAdvancedOptions" class="toggle-control-group">
                        <h4>{{ $t('projects.create_project.administrator_account') }}</h4>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group required">
                                    <label for="admin-first-name">{{ $t('projects.create_project.first_name') }}</label>
                                    <input
                                        id="admin-first-name"
                                        type="text"
                                        v-model="project.adminFirstName"
                                        class="form-control"
                                        name="adminFirstName"
                                        ref="adminFirstNameInput"
                                        v-bind:class="{ invalid: errorBag.has('adminFirstName') }">
                                    <span class="validation-error">{{ $t(errorBag.get('adminFirstName')) }}</span>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group required">
                                    <label for="admin-last-name">{{ $t('projects.create_project.last_name') }}</label>
                                    <input
                                        id="admin-last-name"
                                        type="text"
                                        v-model="project.adminLastName"
                                        class="form-control"
                                        name="adminLastName"
                                        v-bind:class="{ invalid: errorBag.has('adminLastName') }">
                                    <span class="validation-error">{{ $t(errorBag.get('adminLastName')) }}</span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group required">
                                    <label for="admin-login">{{ $t('projects.create_project.login') }}</label>
                                    <input
                                        id="admin-login"
                                        type="text"
                                        v-model="project.adminLogin"
                                        class="form-control"
                                        name="adminLogin"
                                        v-bind:class="{ invalid: errorBag.has('adminLogin') }">
                                    <span class="validation-error">{{ $t(errorBag.get('adminLogin')) }}</span>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group required">
                                    <label for="admin-password">{{ $t('projects.create_project.password') }}</label>
                                    <input
                                        id="admin-password"
                                        type="text"
                                        v-model="project.adminPassword"
                                        class="form-control"
                                        name="adminPassword"
                                        v-bind:class="{ invalid: errorBag.has('adminPassword') }">
                                    <span class="validation-error">{{ $t(errorBag.get('adminPassword')) }}</span>
                                </div>
                            </div>
                        </div>

                        <div class="form-group required">
                            <label for="admin-email">{{ $t('projects.create_project.email') }}</label>
                            <input
                                id="admin-email"
                                type="text"
                                v-model="project.adminEmail"
                                class="form-control"
                                name="adminLogin"
                                v-bind:class="{ invalid: errorBag.has('adminEmail') }">
                            <span class="validation-error">{{ $t(errorBag.get('adminEmail')) }}</span>
                        </div>

                        <h4>{{ $t('projects.create_project.security') }}</h4>

                        <div class="form-group required" data-open-links-in-browser>
                            <label for="encryption-key">
                                {{ $t('projects.create_project.encryption_key') }}
                            </label>
                            <span class="description" v-html="$t('projects.create_project.encryption_key_description')"></span>

                            <input
                                id="encryption-key"
                                type="text"
                                v-model="project.encryptionKey"
                                class="form-control"
                                maxlength="32"
                                name="encryptionKey"
                                v-bind:class="{ invalid: errorBag.has('encryptionKey') }">
                            <span class="validation-error">{{ $t(errorBag.get('encryptionKey')) }}</span>
                        </div>

                        <h4>{{ $t('projects.create_project.development') }}</h4>

                        <div class="form-group" data-open-links-in-browser>
                            <div class="toggle">
                                <label>
                                    <input
                                        name="edge-updates"
                                        value="1"
                                        type="checkbox"
                                        v-model="project.edgeUpdates"/>
                                    <span class="toggle-label">{{ $t('projects.create_project.edge_updates') }}</span>
                                    <span class="description" v-html="$t('projects.create_project.edge_updates_description')"></span>
                                </label>
                            </div>
                        </div>

                        <div class="form-group" data-open-links-in-browser>
                            <div class="toggle">
                                <label>
                                    <input
                                        name="debug-mode"
                                        value="1"
                                        type="checkbox"
                                        v-model="project.debugMode"/>
                                    <span class="toggle-label">{{ $t('projects.create_project.debug_mode') }}</span>
                                    <span class="description" v-html="$t('projects.create_project.debug_mode_description')"></span>
                                </label>
                            </div>
                        </div>

                        <h4>{{ $t('projects.create_project.other_settings') }}</h4>
                        <p data-open-links-in-browser v-html="$t('projects.create_project.other_settings_description')"></p>
                    </div>

                    <div>
                        <input type="submit" class="btn btn-primary" v-bind:value="$t('common.continue')">
                    </div>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
import ErrorBag from '../../validation/error-bag'
import validationHelpers from '../../validation/helpers'
import PreValidator from '../../environments/project-prevalidator'
import DirectoryLocation from '../directory-location.vue'
import platforms from '../../environments/platforms'
import config from '../../config'
import Vue from 'vue'

export default {
    data () {
        return {
            errorBag: new ErrorBag(),

            // We don't use a model for this state,
            // because we want to focus the admin first
            // name input when Use Advanced options is clicked.
            useAdvancedOptions: false
        }
    },
    computed: {
        project () {
            return this.$store.state.projects.newProject
        },
        phpVersion () {
            const platform = platforms.getPlatform()
            var info = config.builtInServerInfo[platform]
            return info ? info.php.version : '7.1'
        }
    },
    components: {
        DirectoryLocation
    },
    methods: {
        goNextStep () {
            const validator = new PreValidator()
            this.errorBag.cleanup()
            validator.validate(this.project, this.errorBag)

            if (!this.errorBag.hasErrors()) {
                this.$emit('show-env-config-step')
            } 
            else {
                validationHelpers.focusFirstField(this.errorBag)
            }
        },

        directoryChanged (ev) {
            if (ev.target.value) {
                this.project.location = ev.target.files[0].path
            }
        },

        onDirectoryClick () {
            this.$refs.directoryInput.click()
        },

        onUseAdvancedOptionsClick () {
            this.useAdvancedOptions = this.$refs.useAdvancedOptions.checked
            this.project.useAdvancedOptions = this.useAdvancedOptions

            if (this.useAdvancedOptions) {
                Vue.nextTick(() => this.$refs.adminFirstNameInput.focus())
            }
        }
    },
    mounted () {
        this.errorBag.cleanup()
        this.useAdvancedOptions = this.project.useAdvancedOptions
        this.$refs.useAdvancedOptions.checked = this.useAdvancedOptions

        Vue.nextTick(() => this.$refs.nameInput.focus())

        $(document).on('click', )
    }
}
</script>