import Vue from 'vue';
import Vuex from 'vuex';
import {authCheck} from './actions';

Vue.use(Vuex);

const state = {
  auth: {
    token: window.localStorage.getItem('token'),
  },
};

const mutations = {
  'SET_AUTH_TOKEN' (state, token) {
    state.auth.token = token;

    if (token === null) {
      window.localStorage.removeItem('token');
      delete Vue.http.options.headers['Authorization'];
    } else {
      window.localStorage.setItem('token', token);
      Vue.http.options.headers['Authorization'] = 'Token ' + token;
    }
  },
};

const store = new Vuex.Store({
  state,
  mutations,
});

authCheck(store);

export default store;
