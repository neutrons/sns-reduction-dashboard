<template>
  <div>
    <nav-bar></nav-bar>
    <main-page></main-page>
  </div>
</template>

<script>
import NavBar from './NavBar.vue';
import MainPage from './MainPage.vue';
import store from '../vuex/store';

export default {
  name: 'App',
  components: {
    NavBar,
    MainPage,
  },
  store,
};
</script>
