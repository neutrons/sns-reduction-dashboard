<template>
  <p>Logging you out now...</p>
</template>

<script>
import { authLogout } from '../vuex/actions';
export default {
  name: 'LogoutRoute',
  vuex: {
    actions: {
      authLogout,
    },
  },
  ready() {
    console.log('LogoutRoute.ready');
    this.authLogout({
      next: () => {
        this.$router.go({'name': 'index'});
      },
    });
  },
}
</script>
