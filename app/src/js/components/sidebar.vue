<template>
    <div class="flex-item sidebar">
        <ul>
            <li class="projects">
                <router-link to="/">{{ $t('projects.title') }}</router-link>
            </li>

            <li class="settings">
                <router-link to="/settings">{{ $t('settings.title') }}</router-link>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    
}
</script>