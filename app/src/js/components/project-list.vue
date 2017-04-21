<template>
    <div class="project-list">
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
    alert('TODO: combine list and search components, use data.fitlerString instead of the global store property');

    function filterClientsAndProjects(filterString, projects) {
        return projects.filter(project => {
            return !filterString.length || project.name.indexOf(filterString) !== -1
        })
    }

    export default {
        computed: {
            filterString () {
                return this.$store.state.projects.listFilterString
            },
            clientsWithNonStarredProjects () {
                return this.$store.state.projects.clients.filter(client => {
                    var projects = client.projects.filter(project => {
                        return ! project.starred
                    })

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

                return filterClientsAndProjects(this.filterString, result)
            },
            selectedProject () {
                return this.$store.state.projects.selectedProject
            }
        },
        methods: {
            setSelectedProject (project) {
                this.$store.dispatch('setSelectedProject', project)
            }
        }
    }
</script>