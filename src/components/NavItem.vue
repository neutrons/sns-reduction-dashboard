<template>
    <li v-link-active>
        <a v-link="{ name: name, activeClass: 'active' }">
            <slot></slot>
        </a>
    </li>
</template>

<script>
export default {
    name: 'NavItem',
    props: {
        name: String,
    },
};
</script>
