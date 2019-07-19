<template>
    <div class="steps-progress-indicator">
        <ul>
            <li v-for="(step, index) in steps" v-bind:class="{active: index == currentStepIndex, done: index < currentStepIndex}">
                <h6>{{ $t(step.name) }}</h6>

                <span class="progress-widget">
                    <span class="progress-indicator"></span>
                </span>
            </li>
        </ul>
    </div>
</template>

<script>

export default {
    props: [
        'steps',
        'currentStepIndex'
    ]
}
</script>