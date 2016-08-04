import resource from '../resource';

function authorizationOptions(token) {
  return {
    headers: {
      'Authorization': 'Token ' + token,
    },
  };
}

export function login({ dispatch }, { username, password }) {
  resource.login.post({ username, password })
    .then(response => {
      var token = response.data.token;

      dispatch('USER_LOGIN', { token });
    }).catch(error => {
      dispatch('USER_LOGOUT');
    });
}

export function authenticate(store) {
  resource.me.get({}, authorizationOptions(store.user.token))
    .then(response => {
      console.log('authenticate then', response);
    }).catch(error => {
      console.log('authenticate catch', error);
    });
}

export function logout({ dispatch }) {
  dispatch('USER_LOGOUT');
}
