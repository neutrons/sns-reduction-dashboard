import Vue from 'vue';
import VueRouter from 'vue-router';

import DefaultRoute from './components/DefaultRoute.vue';
import LoginRoute from './components/LoginRoute.vue';
import Error404Route from './components/Error404Route.vue';
import CatalogRoute from './components/CatalogRoute.vue';
import ReductionRoute from './components/ReductionRoute.vue';
import ConfigurationRoute from './components/ConfigurationRoute.vue';
import JobsRoute from './components/JobsRoute.vue';
import ProfileRoute from './components/ProfileRoute.vue';

Vue.use(VueRouter);

const router = new VueRouter();

router.map({
    '/': {
        name: 'default',
        component: DefaultRoute,
    },
    '/login': {
        name: 'login',
        component: LoginRoute,
    },
    '*source': {
        name: 'general404',
        component: Error404Route,
    },
    '/404': {
        name: '404',
        component: Error404Route,
        source: '404',
    },
    '/catalog/:page': {
        name: 'catalog',
        component: CatalogRoute,
    },
    '/reductions': {
        name: 'reductions',
        component: ReductionRoute,
    },
    '/configurations': {
        name: 'configurations',
        component: ConfigurationRoute,
    },
    '/jobs': {
        name: 'jobs',
        component: JobsRoute,
    },
    '/profile': {
        name: 'profile',
        component: ProfileRoute,
    },
});


router.redirect({
    '/catalog': '/catalog/1',
});

export default router;
