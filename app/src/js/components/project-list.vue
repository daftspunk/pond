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
                <span class="status-indicator starred" v-bind:class="{ online: project.online }"></span>
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
                        v-if="!project.starred"
                        @click="setSelectedProject(project)"
                        v-bind:class="{ selected: selectedProject === project }"
                    >
                        <span class="status-indicator" v-bind:class="{ online: project.online }"></span>
                        <h3>{{ project.name }}</h3>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</template>

<script>
    function filterClientsAndProjects(filterString, projects) {
        return projects.filter(project => {
            return !filterString.length || project.name.toLowerCase().indexOf(filterString.toLowerCase()) !== -1
        })
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

                    // TODO: search by multiple words and client names ("ACME project")
                    // Move filterClientsAndProjects and others to a search utils class.

                    return filterClientsAndProjects(this.filterString, projects).length > 0
                })
            },
            starredProjects () {
                var result = []

                this.$store.state.projects.clients.forEach(client => {
                    return client.projects.forEach(project => {
                        if (project.starred) {
                            result.push(project)
                        }
                    })
                })

                // TODO: search by multiple words and client names ("ACME project")
                // Move filterClientsAndProjects and others to a search utils class.

                return filterClientsAndProjects(this.filterString, result)
            },
            selectedProject () {
                return this.$store.state.projects.selectedProject
            }
        },
        methods: {
            setSelectedProject (project) {
                this.$store.dispatch('setSelectedProject', project)
            },
            filterChanged (string) {
                this.filterString = string
            }
        }
    }
</script>