import Vue from 'vue';
import VueResource from 'vue-resource';
import VueCookie from 'vue-cookie';

Vue.use(VueResource);
Vue.use(VueCookie);

Vue.resource.actions.options = {
  method: 'OPTIONS',
};

Vue.http.options.headers = Vue.http.options.headers || {};
Vue.http.options.headers['X-CSRFToken'] = VueCookie.get('csrftoken');

export default {
  facility: Vue.resource('/configuration/facilities{/pk}'),
  instrument: Vue.resource('/configuration/instruments{/pk}'),
  configuration: Vue.resource('/configuration/configurations{/pk}'),
  entry: Vue.resource('/configuration/entries{/pk}'),
  user: {
    login: Vue.resource('/api/users/login/'),
    authCheck: Vue.resource('/api/users/authCheck/'),
  },
  reduction: {
    configuration: {
      schema: Vue.resource('/api/reduction/configuration/schema/'),
      create: Vue.resource('/api/reduction/configuration/'),
    },
  },
}
