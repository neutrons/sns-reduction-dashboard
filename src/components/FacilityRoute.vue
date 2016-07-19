<template>
  <div class="container">
    <div class="row">
      <div class="col-xs-9">
        <panel :expanded="!selectedFacility" @change="selectFacility(null)">
          <span slot="title">Select a Facility {{ selectedFacility ? '(' + selectedFacility.name + ')' : '' }}</span>
          <div v-show="!$loadingRouteData">
            <table class="table table-hover">
              <thead>
                <th>Name</th>
                <th>Description</th>
              </thead>
              <tbody>
                <tr v-for="facility in results" @click.stop.prevent="selectFacility(facility)">
                  <td>{{ facility.name }}</td>
                  <td>{{ facility.desc }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </panel>

        <panel :expanded="!selectedInstrument" @change="selectInstrument(null)">
          <span slot="title">Select an Instrument {{ selectedInstrument ? '(' + selectedInstrument.name + ')' : '' }}</span>
          <div>
            <table class="table table-hover">
              <thead>
                <th>Name</th>
                <th>Description</th>
              </thead>
              <tbody>
                <tr v-for="instrument in results">
                  <td>{{ instrument.name }}</td>
                  <td>{{ instrument.desc }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </panel>
      </div>
      <div class="col-xs-3">
        <panel>
          <span slot="title">Breadcrumbs</span>
        </panel>
      </div>
    </div>
  </div>
</template>

<script>
import { facility } from '../resource';
import Panel from './Panel.vue';

export default {
  name: 'FacilityRoute',
  data() {
    return {
      count: null,
      next: null,
      previous: null,
      results: null,
      selectedFacility: null,
    };
  },
  methods: {
    selectFacility(facility) {
      this.selectedFacility = facility;
    },
  },
  route: {
    data({ next }) {
      facility.get().then(response => {
        next(response.json());
      });
    },
  },
  components: {
    Panel,
  },
};
</script>
