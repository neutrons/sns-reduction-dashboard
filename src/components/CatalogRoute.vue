<template>
  <div class="row">
    <div class="col-xs-9">
      <panel>
        <span slot="title">Facility</span>
        <div class="container-fluid">
          <div class="row">
            <div class="col-xs-3 col-xs-offset-3">
              <button class="btn btn-block btn-default">SNS</button>
            </div>
            <div class="col-xs-3">
              <button class="btn btn-block btn-default">HFIR</button>
            </div>
          </div>
        </div>
      </panel>

      <panel v-if="hasFacility">
        <span slot="title">Instrument</span>
        <div class="container-fluid">
          <div class="row">
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>Name</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="instrument in instruments">
                  <td>{{instrument.name}}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </panel>
    </div>
    <div class="col-xs-3">
      <sidebar-panel>
        <span slot="title">Catalog</span>
        <div class="list-group-item" slot="body">
          <a class="list-group-item" href="">Item 001</a>
          <a class="list-group-item" href="">Item 002</a>
          <a class="list-group-item" href="">Item 003</a>
        </div>
      </sidebar-panel>
    </div>
  </div>
</template>

<script>
import Panel from './Panel.vue';
import SidebarPanel from './SidebarPanel.vue';
import TimeAgo from '../directives/time-ago';
import TimeDiff from '../directives/time-diff';
import loading from 'vue-loading';

import { catalog } from '../resource';
import { route } from '../vuex/getters';

export default {
  name: 'CatalogRoute',
  components: {
    SidebarPanel,
    Panel,
  },
  directives: {
    TimeAgo,
    TimeDiff,
    loading,
  },
  data() {
    return { status: 'pending', data: null, message: null, hasFacility: true, instruments: [ {name:'Foo'}, {name:'Bar'} ] };
  },
  vuex: {
    getters: {
      route,
    },
  },
  route: {
    data({ next }) {
      catalog.get({page: this.route.params.page}).then(response => {
        next(response.json());
      });
    },
  },
};
</script>
