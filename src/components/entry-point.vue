<script>
Vue.use(VueRouter);

var router = new VueRouter();

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
    '/catalog': {
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
});

router.start(App, '#vue-attach');
</script>
