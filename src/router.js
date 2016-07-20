import Vue from 'vue';
import VueRouter from 'vue-router';

import DefaultRoute from './components/DefaultRoute.vue';
import CatalogRoute from './components/CatalogRoute.vue';

Vue.use(VueRouter);

const router = new VueRouter();

router.map({
  '/': {
    name: 'default',
    component: DefaultRoute,
  },
  '/catalog': {
    name: 'catalog',
    component: CatalogRoute,
  },
});

export default router;
