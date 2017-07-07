<template>
    <div class="layout-full-size layout-flex-rows-container">
        <div class="layout-flex-row screen-header">
            <h3>{{ $t('projects.create_project.title') }}</h3>
            <h4>{{ $t('projects.create_project.provisioning') }}</h4>

            <span class="header-icon close-screen-router-link" v-if="isError">
                <router-link tag="span" to="/">
                    <a class="close-screen-link" v-bind:disabled="waiting">{{ $t('common.close') }}</a>
                </router-link>
            </span>
        </div>

        <div class="layout-flex-row layout-relative standard-padding-bottom">
            <div class="standard-panel-paddings standard-padding-top">
                <div class="row">
                    <div class="col-sm-12 double-padding-top text-center standard-padding-bottom" v-if="!isError">
                        <h3 class="standard-padding-bottom">{{ $t('projects.create_project.pond_building_project') }}</h3>

                        <steps-progress-indicator
                            v-bind:steps="progressSteps"
                            v-bind:current-step-index="project.runtime.initState.step"
                        ></steps-progress-indicator>
                    </div>

                    <div class="col-sm-12" v-if="isError">
                        <template v-if="!errors">
                            <h3 class="standard-padding-bottom">{{ $t('projects.create_project.error') }}</h3>

                            <div class="standard-padding-bottom">
                                <div class="error-message"><p>{{ $t(errorMessage) }}</p></div>
                            </div>
                        </template>
                        <template v-else>
                            <h3 class="standard-padding-bottom">{{ $t(errorMessage) }}</h3>

                            <table class="numbered-message-list">
                                <tr v-for="(error, errorKey, errorIndex) in errors">
                                    <th>
                                        <div class="error">{{errorIndex+1}}</div>
                                    </th>
                                    <td class="styled-text-document" v-html="errorToHtml(error)">
                                    </td>
                                </tr>
                            </table>
                        </template>

                        <input type="submit" class="btn btn-primary" @click="goPrevStep()" v-bind:value="$t('common.go_back_button')">
                    </div>
                </div>
            </div>
        </div>

        <div class="layout-flex-row layout-stretch layout-flex-rows-container layout-relative min-height-200">
            <div class="layout-full-size">
                <log-panel v-bind:log="project.runtime.initState.textLog" no-toolbar-controls="1"></log-panel>
            </div>
        </div>
    </div>
</template>

<script>
import InitializerFactory from '../../environments/initializer-factory'
import InitializationState from '../../environments/initialization-state'
import StepsProgressIndicator from './steps-progress-indicator.vue'
import LogPanel from '../log-panel.vue'
import Vue from 'vue'
import errorHandlingUtils from '../../error-handling/utils'
import marked from 'marked'

export default {
    data () {
        return {
            isError: false,
            errorMessage: '',
            errors: [],
            progressSteps: [
                {name: 'projects.create_project.downloading'},
                {name: 'projects.create_project.initializing'},
                {name: 'projects.create_project.installing'},
                {name: 'projects.create_project.done'}
            ]
        }
    },
    components: {
        StepsProgressIndicator,
        LogPanel
    },
    computed: {
        project () {
            return this.$store.state.projects.newProject
        }
    },
    methods: {
        goPrevStep () {
            this.$emit('show-env-config-step')
        },
        errorToHtml(text) {
            return marked(text)
        }
    },
    mounted () {
        const initializer = InitializerFactory.createInitializer(this.project)
        this.project.runtime.initState.textLog.clear()

        initializer.initProject().then(() => {
            this.$emit('show-done-step')
        }).catch((err) => {
            var errorStr = errorHandlingUtils.getErrorString(err)

            this.project.runtime.initState.textLog.addLine('ERROR. ' + this.$t(errorStr))

            this.isError = true
            this.errorMessage = errorStr
            this.errors = err.errors

            console.log(err)
        })
    }
}
</script>