import Vue from 'vue';
import VueRouter from 'vue-router';

import DefaultRoute from './components/DefaultRoute.vue';
import FacilityRoute from './components/FacilityRoute.vue';
import InstrumentRoute from './components/InstrumentRoute.vue';
import ConfigurationRoute from './components/ConfigurationRoute.vue';
import EntryRoute from './components/EntryRoute.vue';

Vue.use(VueRouter);

const router = new VueRouter();

router.map({
  '/': {
    name: 'default',
    component: DefaultRoute,
  },
  '/facility': {
    name: 'facility',
    component: FacilityRoute,
  },
  '/instrument': {
    name: 'instrument',
    component: InstrumentRoute,
  },
  '/configuration': {
    name: 'configuration',
    component: ConfigurationRoute,
  },
  '/entry': {
    name: 'entry',
    component: EntryRoute,
  },
});

export default router;
