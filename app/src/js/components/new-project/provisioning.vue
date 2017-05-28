<template>
    <div class="layout-full-size layout-flex-rows-container" v-bind:class="{waiting: waiting}">
        <div class="layout-flex-row screen-header">
            <h3>{{ $t('projects.create_project.title') }}</h3>
            <h4>{{ $t('projects.create_project.provisioning') }}</h4>
        </div>

        <form class="layout-flex-row layout-relative" @submit.prevent="goFinalStep">
            
                <div class="standard-panel-paddings standard-padding-bottom standard-padding-top">
                    <div class="row">
                        <div class="col-sm-12 double-padding-top text-center standard-padding-bottom">
                            <h3 class="standard-padding-top standard-padding-bottom">{{ $t('projects.create_project.pond_building_project') }}</h3>

                            <div class="double-padding-top">
                                <steps-progress-indicator
                                    v-bind:steps="progressSteps"
                                    v-bind:current-step-index="currentStepIndex"
                                ></steps-progress-indicator>
                            </div>
                        </div>
                    </div>
                </div>
            
        </form>

        <div class="layout-flex-row layout-stretch layout-flex-rows-container layout-relative">
            <div class="layout-full-size">
                <log-panel v-bind:log="project.initLog" no-toolbar-controls="1"></log-panel>
            </div>
        </div>
    </div>
</template>

<script>
import Environments from '../../environments'
import StepsProgressIndicator from './steps-progress-indicator.vue'
import LogPanel from '../log-panel.vue'
import Vue from 'vue'

export default {
    data () {
        return {
            waiting: true,
            currentStepIndex: 1,
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

    },
    mounted () {
        
    }
}
</script>