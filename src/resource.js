import Vue from 'vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

export default {};

export const catalog = Vue.resource('/catalog{/page}');
