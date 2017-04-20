<template>
    <div class="project-list">
        <ul v-if="clientsWithNonStarredProjects">
            <li v-for="client in clientsWithNonStarredProjects">
                <h2>{{ client.name }}</h2>

                <ul>
                    <li v-for="project in client.projects" v-if="!project.starred">
                        <span class="status-indicator" v-bind:class="{ online: project.online }"></span>
                        <h3>{{ project.name }}</h3>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    computed: {
        clientsWithNonStarredProjects () {
            return this.$store.state.projects.clients.filter(client => {
                return client.projects.some(project => {
                    return ! project.starred
                })
            })
        }
    }
}
</script>