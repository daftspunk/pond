<template>
    <div class="project-list">
        <div class="projects-search">
            <input type="text" class="form-control" v-model="filterString" :placeholder="$t('projects.find_placeholder')">
        </div>

        <ul class="starred-projects" v-if="starredProjects">
            <li
                class="project"
                v-for="project in starredProjects"
                @click="setSelectedProject(project)"
                v-bind:class="{ selected: selectedProject === project }"
            >
                <span class="status-indicator starred" v-bind:class="{ online: project.runtime.status == 'online' }"></span>
                <h3>{{ project.name }}</h3>
            </li>
        </ul>

        <ul class="non-starred-projects" v-if="clientsWithNonStarredProjects">
            <li class="client" v-for="client in clientsWithNonStarredProjects">
                <h2>{{ client.name }}</h2>

                <ul>
                    <li
                        class="project"
                        v-for="project in client.projects"
                        @click="setSelectedProject(project)"
                        v-bind:class="{ selected: selectedProject === project }"
                    >
                        <span class="status-indicator" v-bind:class="{ online: project.runtime.status == 'online' }"></span>
                        <h3>{{ project.name }}</h3>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</template>

<script>
import searchUtils from '../projects/search-utils'

export default {
    data () {
        return {
            filterString: ''
        }
    },
    computed: {
        projects () {
            return this.$store.state.projects.list
        },
        filteredProjects () {
            return this.projects
                    .filter(project => searchUtils.projectMatchesSearchString(project, this.filterString))
                    .sort((a, b) => a.name.localeCompare(b.name))
        },
        starredProjects () {
            return this.filteredProjects.filter(({starred}) => starred)
        },
        clientsWithNonStarredProjects () {
            var clients = []
            const projects = this.filteredProjects.filter(({starred}) => !starred)

            projects.forEach(project => {
                const clientIndex = clients.findIndex(client => client.name == project.client)

                if (clientIndex < 0) {
                    clients.push({
                        name: project.client,
                        projects: [project]
                    })
                }
                else {
                    clients[clientIndex].projects.push(project)
                }
            })

            return clients.sort((a, b) => a.name.localeCompare(b.name))
        },
        selectedProject () {
            return this.$store.state.projects.selectedProject
        }
    },
    methods: {
        setSelectedProject (project) {
            this.$store.dispatch('setSelectedProject', {project})
        },
        filterChanged (string) {
            this.filterString = string
        }
    }
}
</script>