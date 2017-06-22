<template>
    <div class="layout-full-size layout-flex-rows-container" v-bind:class="{waiting: waiting}">
        <div class="layout-flex-row screen-header">
            <h3>{{ $t('projects.create_project.title') }}</h3>
            <h4>{{ $t('projects.create_project.configure_pond_environment') }}</h4>

            <span class="header-icon close-screen-router-link">
                <router-link tag="span" to="/">
                    <a class="close-screen-link" v-bind:disabled="waiting">{{ $t('common.close') }}</a>
                </router-link>
            </span>
        </div>

        <form class="layout-flex-row layout-stretch layout-relative" @submit.prevent="goFinalStep">
            <div class="layout-full-size scrollable">
                <div class="standard-panel-paddings standard-padding-bottom standard-padding-top">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="form-group required">
                                <div class="field-prefixed" v-bind:class="{ invalid: errorBag.has('localPort') }">
                                    <div class="prefix">
                                        http://localhost:
                                    </div>
                                    <div class="field">
                                        <label ref="localPortLabel" for="project-local-port">{{ $t('projects.create_project.local_port') }}</label>
                                        <input
                                            id="project-local-port"
                                            type="text"
                                            v-model="project.localPort"
                                            class="form-control"
                                            ref="localPortInput"
                                            name="localPort"
                                            v-bind:disabled="waiting"
                                            v-bind:class="{ invalid: errorBag.has('localPort') }">
                                        <span class="field-prefixed-marker"></span>
                                    </div>
                                </div>
                                <span class="validation-error">{{ $t(errorBag.get('localPort')) }}</span>
                            </div>

                            <p
                                class="standard-padding-bottom"
                                data-open-links-in-browser
                                v-html="$t('projects.create_project.local_port_description')"></p>
                        </div>

                        <div class="col-sm-3">
                            <div class="decoration-image pond-server-graphics align-to-form-label"></div>
                        </div>
                    </div>

                    <input
                        type="submit"
                        class="btn btn-primary"
                        v-bind:value="waiting ? $t('common.please_wait') : $t('common.continue')" v-bind:disabled="waiting">

                    <span class="button-or">or</span>
                    <button type="button" class="btn btn-link" @click="goPrevStep()" v-bind:disabled="waiting">{{ $t('common.go_back') }}</button>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
import ErrorBag from '../../validation/error-bag'
import validationHelpers from '../../validation/helpers'
import PortFinder from '../../environments/port-finder'
import InitializerFactory from '../../environments/initializer-factory'
import Vue from 'vue'

export default {
    data () {
        return {
            errorBag: new ErrorBag(),
            waiting: false
        }
    },
    computed: {
        project () {
            return this.$store.state.projects.newProject
        }
    },
    methods: {
        validateAndGoToNext () {
            const initializer = InitializerFactory.createInitializer(this.project)

            initializer.validateProvisionerConfiguration(this.errorBag,
                this.$store.state.projects.list)
                .then(() => {
                    this.waiting = false
                    if (!this.errorBag.hasErrors()) {
                        this.$emit('show-provisioning-step')
                    }
                    else {
                        validationHelpers.focusFirstField(this.errorBag)
                        this.$forceUpdate()
                    }
                })
                .catch(e => {
                    this.waiting = false
                    throw e
                })
        },
        goFinalStep () {
            this.errorBag.cleanup()
            this.waiting = true
            
            setTimeout(() => this.validateAndGoToNext(), 500)
        },
        goPrevStep () {
            this.$emit('show-general-step')
        }
    },
    mounted () {
        this.errorBag.cleanup()

        if (!this.project.localPort) {
            this.project.localPort = PortFinder.getNextPort(this.$store.state.projects.list)
        }

        Vue.nextTick(_ => this.$refs.localPortInput.focus())
    }
}
</script>