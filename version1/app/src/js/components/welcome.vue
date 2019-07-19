<template>
    <div class="flex-item welcome-to-pond">
        <div>
            <h3>{{ $t('projects.welcome') }}</h3>
            <p class="double-padding-top">{{ $t('projects.no_projects') }}</p>
            <p class="text-center double-padding-top">
                <a class="btn btn-primary" @click.stop.prevent="createProject">{{ $t('projects.create_first_project') }}</a>
            </p>
        </div>
    </div>
</template>

<script>
export default {
    methods: {
        createProject () {
            this.$router.push('/new-project')
        }
    },
}
</script>
