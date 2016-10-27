<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-6 col-xs-offset-3">
        <panel>
          <form>
            <vue-form-generator :schema="schema" :model="model">
            </vue-form-generator>
          </form>
        </panel>
      </div>
    </div>
  </div>
</template>

<script>
import Panel from './Panel.vue';
import { component as VueFormGenerator } from 'vue-form-generator';
import resource from '../resource.js';

export default {
  name: 'ConfigurationNewRoute',

  components: {
    Panel,
    VueFormGenerator,
  },

  route: {
    data({ next, abort }) {
      resource.reduction.configuration.schema.get().then((response) => {
        next(response.json());
      }).catch((response) => {
        abort(response.json());
      });
    },
  },

  data() {
    return {
      schema: null,
      model: null,
    };
  },
};
</script>
