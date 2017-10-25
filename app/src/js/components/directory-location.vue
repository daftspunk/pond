<template>
    <div class="directory-location form-control">
        <ul v-if="segments.length > 0">
            <li v-for="segment in segments">{{ segment }}</li>
        </ul>
        <div class="placeholder" v-else>{{ $t(placeholder) }}</div>
    </div>
</template>

<script>
export default {
    props: [
        'location',
        'placeholder'
    ],
    computed: {
        segments () {
            if ( typeof this.location !== 'string' ) {
                return []
            }

            return this.location.split(/\\|\//).filter(str => str.length > 0)
        }
    },
    methods: {
    },
    mounted () {
    }
}
</script>