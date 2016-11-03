import Vue from 'vue';
import VueRouter from 'vue-router';

import DefaultRoute from './components/DefaultRoute.vue';
import CatalogRoute from './components/CatalogRoute.vue';
import LoginRoute from './components/LoginRoute.vue';
import ProfileRoute from './components/ProfileRoute.vue';
import ReductionRoute from './components/ReductionRoute.vue';
import ReductionTabRoute from './components/ReductionTabRoute.vue';
import LogoutRoute from './components/LogoutRoute.vue';
import ConfigurationNewRoute from './components/ConfigurationNewRoute.vue';

import store from './vuex/store';
import { loggedIn } from './vuex/getters';

Vue.use(VueRouter);

const router = new VueRouter();

router.map({

  '/': {
    name: 'index',
    component: DefaultRoute,
  },

  '/catalog': {
    name: 'catalog',
    component: CatalogRoute,
  },

  '/login': {
    name: 'login',
    component: LoginRoute,
  },

  '/logout': {
    name: 'logout',
    component: LogoutRoute,
  },

  '/profile': {
    name: 'profile',
    component: ProfileRoute,
    auth: true,
  },

  '/reduction': {
    name: 'reduction',
    component: ReductionRoute,
  },

  '/configuration/new': {
    name: 'configuration-new',
    component: ConfigurationNewRoute,
    auth: true,
  },

});

router.beforeEach(function({ to, next, abort }) {
  if (to.auth) {
    if (loggedIn(store.state)) {
      next();
    } else {
      router.go({ name: 'login', query: { next: to.path }});
    }
  } else {
    next();
  }
});

export default router;
