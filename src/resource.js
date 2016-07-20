import Vue from 'vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

export default {};

export const facility = Vue.resource('/configuration/facilities{/pk}');
export const instrument = Vue.resource('/configuration/instruments{/pk}');
export const configuration = Vue.resource('/configuration/configurations{/pk}');
export const entry = Vue.resource('/configuration/entries{/pk}');
