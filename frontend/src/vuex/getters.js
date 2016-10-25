export function authToken(state) {
  return state.auth.token;
};

export function loggedIn(state) {
  return authToken(state) !== null;
};

export function route({ route }) {
  return route;
};

export default {
  authToken,
  loggedIn,
  route,
};
