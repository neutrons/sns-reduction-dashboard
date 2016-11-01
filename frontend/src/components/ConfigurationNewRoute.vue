<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-6 col-xs-offset-3">
        <panel>
          <form>
            <vue-form-generator :schema="title.schema" :model="model" :options="{}">
            </vue-form-generator>
            <vue-form-generator :schema="schema"
                                :model="model"
                                :options="{}">
            </vue-form-generator>
            <button type="submit"
                    class="btn btn-default"
                    @click.prevent.stop="submit">
              Submit
            </button>
          </form>
          <pre v-html="model|json"></pre>
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
      model: {
        title: 'Foo',
      },
      title: {
        schema: {
          fields: [
            {
              type: 'text',
              required: true,
              hint: 'The title for your configuration',
              label: 'Configuration Title',
              model: 'title',
            },
          ],
        },
        value: '',
      },
    };
  },

  methods: {
    submit() {
      console.log(JSON.stringify(this.model, true, 2));
    },
  },
};
</script>
