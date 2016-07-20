<template>
  <div class="App">
    <nav-bar></nav-bar>
    <div class="App__main-page">
      <main-page></main-page>
    </div>
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

<style>
.App__main-page {
  margin-top: 50px;
  padding: 20px;
}
</style>
