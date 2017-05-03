<template>
    <div class="project-list">
        <div class="projects-search">
            <input type="text" class="form-control" v-model="filterString" :placeholder="$t('projects.find_placeholder')">
        </div>

        <ul class="starred-projects" v-if="clientsWithStarredProjects">
            <template v-for="client in clientsWithStarredProjects">
                <li
                    class="project"
                    v-for="project in client.projects"
                    v-if="project.starred && matchesFilter(project)"
                    @click="setSelectedClientAndProject(project, client)"
                    v-bind:class="{ selected: selectedProject === project }"
                >
                    <span class="status-indicator starred" v-bind:class="{ online: project.runtime.status == 'online' }"></span>
                    <h3>{{ project.name }}</h3>
                </li>
            </template>
        </ul>

        <ul class="non-starred-projects" v-if="clientsWithNonStarredProjects">
            <li class="client" v-for="client in clientsWithNonStarredProjects">
                <h2>{{ client.name }}</h2>

                <ul>
                    <li
                        class="project"
                        v-for="project in client.projects"
                        v-if="!project.starred && matchesFilter(project)"
                        @click="setSelectedClientAndProject(project, client)"
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
    import projectSearchUtils from '../projects/search-utils'

    function filterClientsAndProjects(filterString, projects) {
        return projects.filter(project => projectSearchUtils.projectMatchesSearchString(project, filterString))
    }

    export default {
        data () {
            return {
                filterString: ''
            }
        },
        computed: {
            clientsWithNonStarredProjects () {
                return this.$store.state.projects.clients.filter(client => {
                    var projects = client.projects.filter(project => {
                        return ! project.starred
                    })

                    // TODO: search by multiple words and client names

                    projects = filterClientsAndProjects(this.filterString, projects)

                    return projects.length > 0
                })
            },
            clientsWithStarredProjects () {
                return this.$store.state.projects.clients.filter(client => {
                    var projects = client.projects.filter(project => {
                        return project.starred
                    })

                    // TODO: search by multiple words and client names

                    projects = filterClientsAndProjects(this.filterString, projects)

                    return projects.length > 0
                })
            },
            selectedProject () {
                return this.$store.state.projects.selectedProject
            },
            selectedClient () {
                return this.$store.state.projects.selectedClient
            }
        },
        methods: {
            setSelectedClientAndProject (project, client) {
                this.$store.dispatch('setSelectedClientAndProject', {project, client})
            },
            filterChanged (string) {
                this.filterString = string
            },
            matchesFilter (project) {
                return projectSearchUtils.projectMatchesSearchString(project, this.filterString)
            }
        }
    }
</script>