import Vue from 'vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

export default {
  facility: Vue.resource('/configuration/facilities{/pk}'),
  instrument: Vue.resource('/configuration/instruments{/pk}'),
  configuration: Vue.resource('/configuration/configurations{/pk}'),
  entry: Vue.resource('/configuration/entries{/pk}'),
  login: Vue.resource('/api-token-auth'),
  me: Vue.resource('/user/me'),
  profile: Vue.resource('/user{/pk}'),
}
