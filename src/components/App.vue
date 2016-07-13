<style>
/*
 * Base structure
 */

/* Move down content because we have a fixed navbar that is 50px tall */
body {
    padding-top: 70px;
}

/*
 * Global add-ons
 */

.sub-header {
    padding-bottom: 10px;
    border-bottom: 1px solid #eee;
}

/*
 * Top navigation
 * Hide default border to remove 1px line.
 */
.navbar-fixed-top {
    border: 0;
}

/*
 * Main content
 */

.main {
    padding: 20px;
}
@media (min-width: 768px) {
    .main {
        padding-right: 40px;
        padding-left: 40px;
    }
}
.main .page-header {
    margin-top: 0;
}

body {
    background-color: #f9f9f9;
}

/*
 * Box
 */

.box {
    position: relative;
    margin-bottom: 20px;
    width: 100%;
    background-color: #fff;
    border: 1px solid #f4f4f4;
    border-top: 3px solid rgb(210, 214, 222);
    border-radius: 3px;
    box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
}

/*
 * Dropdown hover hack
 */
.dropdown-hover:hover > .dropdown-menu {
    display: block;
    margin-top: 0;
}

</style>

<template>
    <div>
        <navbar></navbar>
        <main-page></main-page>
    </div>
</template>

<script>
import Navbar from './Navbar.vue';
import MainPage from './MainPage.vue';
import store from '../vuex/store';

export default {
    name: 'App',
    components: {
        Navbar,
        MainPage,
    },
    store,
};
</script>
