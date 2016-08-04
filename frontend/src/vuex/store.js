import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const state = {
  user: {
    authenticated: false,
    token: localStorage.getItem('token'),
  },
};

const mutations = {
  'USER_LOGIN' ({ user }, { token }) {
    user.authenticated = true;
    user.token = token;
    localStorage.setItem('token', token);
  },

  'USER_LOGOUT' ({ user }) {
    user.authenticated = false;
    user.token = null;
    localStorage.removeItem('token');
  },
};

export default new Vuex.Store({
  state,
  mutations,
});
