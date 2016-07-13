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
                <a class="navbar-brand" v-link="{ name: 'default' }">ORNL | SNS | HFIR</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <nav-item :params="{page:1}" name="catalog">Catalog</nav-item>
                    <nav-item name="reductions">Reductions</nav-item>
                    <nav-item name="configurations">Configurations</nav-item>
                    <nav-item name="jobs">Jobs</nav-item>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown dropdown-hover" >
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"  role="button" >Dev</a>
                        <ul class="dropdown-menu" >
                            <nav-item name="404">404</nav-item>
                            <nav-item name="login">Login</nav-item>
                        </ul>
                    </li>

                    <nav-item name="profile">
                        <span class="glyphicon glyphicon-user"></span>
                    </nav-item>
                </ul>
            </div>
        </div>
    </nav>
</template>

<script>
import NavItem from './NavItem.vue';

export default {
    name: 'Navbar',
    components: {
        NavItem,
    },
};
</script>
