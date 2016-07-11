import Vue from 'expose?Vue!vue';
import VueRouter from 'vue-router';
import routes from './routes';
import App from './components/App.vue';

Vue.use(VueRouter);

var router = new VueRouter();

router.map(routes);

router.start(App, '#app');
