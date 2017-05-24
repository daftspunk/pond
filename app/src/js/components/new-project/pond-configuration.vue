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
                        <div class="col-sm-12">
                            <div class="input-field">
                                <input
                                    id="project-local-port"
                                    type="text"
                                    v-model="project.localPort"
                                    class="validation"
                                    ref="localPortInput"
                                    v-bind:class="{ invalid: errorBag.has('localPort') }">
                                <label class="active" ref="localPortLabel" for="project-local-port">{{ $t('projects.create_project.local_port') }}</label>
                                <span class="validation-error">{{ $t(errorBag.get('localPort')) }}</span>
                            </div>

                            <p class="standard-padding-top standard-padding-bottom" data-open-links-in-browser v-html="$t('projects.create_project.local_port_description')"></p>

                            <table class="table attribute-table" data-open-links-in-browser>
                                <tr>
                                    <th class="min-width">{{ $t('projects.create_project.new_url_label') }}</th>
                                    <td>http://localhost:{{ project.localPort }}/</td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <input type="submit" class="btn btn-primary" v-bind:value="$t('common.continue')">
                </div>
            </div>
        </form>
    </div>
</template>

<script>
import ErrorBag from '../../validation/error-bag'
import PortFinder from '../../environments/port-finder'
import Vue from 'vue'

export default {
    data () {
        return {
            errorBag: new ErrorBag()
        }
    },
    computed: {
        project () {
            return this.$store.state.projects.newProject
        }
    },
    methods: {
        goNextStep () {
           
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