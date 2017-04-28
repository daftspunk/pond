<template>
    <div class="flex-item current-project-view-panel">
        <div v-if="selectedProject" class="project-view-contents layout-full-size layout-flex-rows-container">

            <div class="layout-flex-row">
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

                <div class="standard-panel-paddings" data-open-links-in-browser v-html="description"></div>

                <div class="standard-panel-paddings standard-padding-bottom">
                    <table class="table attribute-table" data-open-links-in-browser>
                        <tr>
                            <th>{{ $t('projects.server') }}</th>
                            <td>{{ $t(serverType) }}</td>
                        </tr>
                        <tr>
                            <th>{{ $t('projects.location') }}</th>
                            <td>{{ selectedProject.location }}</td>
                        </tr>
                        <tr>
                            <th>{{ $t('projects.local') }}</th>
                            <td><a v-bind:href="localUrl">{{ localUrl }}</a></td>
                        </tr>
                        <tr>
                            <th>{{ $t('projects.production') }}</th>
                            <td><a v-bind:href="productionUrl">{{ productionUrl }}</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="layout-flex-row layout-stretch layout-flex-rows-container">
                <div class="material-tabs layout-flex-row layout-stretch layout-flex-rows-container">
                    <ul class="tabs layout-flex-row">
                        <li class="active"><a href="#tab-application-log" data-toggle="tab">{{ $t('projects.application_log') }}</a></li>
                        <li><a href="#tab-php-log" data-toggle="tab">{{ $t('projects.php_log') }}</a></li>
                        <li><a href="#tab-error-log" data-toggle="tab">{{ $t('projects.error_log') }} <span class="badge badge-error">4</span></a></li>
                    </ul>

                    <div class="tab-content layout-flex-row layout-stretch layout-flex-rows-container layout-relative">
                        <div role="tabpanel" class="tab-pane active layout-full-size" id="tab-application-log">
                            <log-panel></log-panel>
                        </div>
                        <div role="tabpanel" class="tab-pane layout-full-size" id="tab-php-log">
                            <log-panel></log-panel>
                        </div>
                        <div role="tabpanel" class="tab-pane layout-full-size" id="tab-error-log">
                            <log-panel></log-panel>
                        </div>
                    </div>
                </div>
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
import {markdown} from "markdown"
import {typeToString} from "../projects/server-types-enum"
import LogPanel from "./log-panel.vue"
export default {
    computed: {
        selectedProject () {
            return this.$store.state.projects.selectedProject
        },
        selectedClient () {
            return this.$store.state.projects.selectedClient
        },
        description () {
            if (!this.selectedProject) {
                return ''
            }

            return this.selectedProject.description === undefined ? '' : markdown.toHTML(this.selectedProject.description)
        },
        serverType () {
            if (!this.selectedProject) {
                return ''
            }

            return typeToString(this.selectedProject.serverType)
        },
        localUrl () {
            return 'http://localhost:9291'
        },
        productionUrl () {
            return 'http://landing.acme.com'
        }
    },
    methods: {
        toggleStar (project) {
            this.$store.dispatch('toggleProjectStar', project)
        }
    },
    components: {
        LogPanel
    }
}
</script>