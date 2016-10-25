import resource from '../resource';
import getters from './getters';

function authorizationOptions(token) {
  return {
    headers: {
      'Authorization': 'Token ' + token,
    },
  };
}
export function authLogin({ dispatch }, { next, abort }, creds) {
  resource.user.login.save({}, creds)
    .then((response) => {
      console.log('login.then', response);

      var json = response.json(),
          token = json.token;

      dispatch('SET_AUTH_TOKEN', token);

      if (next) next(json);
    }).catch((response) => {
      console.log('login.catch', response);

      if (abort) abort(response.json());
    });
};

export function authLogout({ dispatch }, { next, abort }) {
  dispatch('SET_AUTH_TOKEN', null);

  if (next) next();
};

export function authCheck({ dispatch, state }, { next, abort }={}) {
  var token = getters.authToken(state);

  resource.user.authCheck.save({}, {token})
    .then((response) => {
      console.log('authCheck.then', response);

      var json = response.json();

      if (json.username !== null) {
        console.log('authCheck: user logged in');
        dispatch('SET_AUTH_TOKEN', token);

        if (next) next(json);
      } else {
        console.log('authCheck: user not logged in');

        dispatch('SET_AUTH_TOKEN', null);

        if (abort) abort(json);
      }
    });
}
