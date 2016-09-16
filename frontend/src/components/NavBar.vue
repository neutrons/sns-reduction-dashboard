<template>
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" v-link="{ name: 'default' }"><img src="../assets/logo.jpg" alt="Dispute Bills"></a>
      </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <nav-item name="catalog"><span class="glyphicon glyphicon-book"></span> &nbsp;Catalog</nav-item>
          <nav-item name="reduction"><span class="glyphicon glyphicon-th-list"></span> &nbsp;Configuration</nav-item>
          <nav-item name="reduction"><span class="glyphicon glyphicon-th"></span> &nbsp;Reduction</nav-item>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown dropdown-hover" >
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"  role="button" >Dev</a>
            <ul class="dropdown-menu" >
              <nav-item name="login">Login</nav-item>
              <nav-item name="profile"><span class="glyphicon glyphicon-user"></span> &nbsp;Profile</nav-item>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<style>

.navbar-brand {
  padding: 0px;
}
.navbar-brand>img {
  width: auto;
  display: inline-block;
  height: 52px;
  margin-top: -15px
}

</style>

<script>
import NavItem from './NavItem.vue';
export default {
  name: 'NavBar',
  components: {
    NavItem,
  },
};
</script>
