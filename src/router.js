import Vue from 'vue';
import VueRouter from 'vue-router';

import DefaultRoute from './components/DefaultRoute.vue';

Vue.use(VueRouter);

const router = new VueRouter();

router.map({
  '/': {
    name: 'default',
    component: DefaultRoute,
  },
});

export default router;
