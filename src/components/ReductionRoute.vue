<template>
  <div>
    <div class="col-xs-9">
      <panel>
        <span slot="title">Reduction</span>
        <div class="form-group">
          <div class="form-group">
            <label for="reduction-route-title">Title</label>
            <input type="text" id="reduction-route-title" class="form-control" placeholder="title"/>
          </div>

          <div class="form-group">
            <label for="reduction-route-ipts">IPTS</label>
            <input type="text" id="reduction-route-ipts" class="form-control" placeholder="ipts"/>
          </div>

          <div class="form-group">
            <label for="reduction-route-configuration">Configuration</label>
            <input type="text" id="reduction-route-configuration" class="form-control" placeholder="configuration"/>
          </div>

        </div>

        <ul role="tablist" class="nav nav-tabs" style="margin-bottom:15px">
          <li v-for="tab in tabs" role="presentation" :class="{ 'active': tab.active }">
            <a role="tab" v-link="{ name: 'reduction' }" @click.stop.prevent="setActiveTab(tab)">
              {{ tab.name }}
            </a>

          </li>
          <li role="presentation">
            <a href="" role="tab" v-link="{ name: 'reduction' }" @click=""><span class="glyphicon glyphicon-plus"></span></a>
          </li>
        </ul>

        <div class="tab-content">

          <div class="form-group">
            <label for="reduction-route-beam-center">Beam Center</label>
            <input type="text" id="reduction-route-beam-center" class="form-control" placeholder="beam center"/>
          </div>

          <div role="tabpanel" class="tab-pane active" role="tabpanel">
            <handsontable :data="activeTab.data" :settings="tableOptions"></handsontable>
          </div>
        </div>
      </panel>
    </div>
  </div>
</template>

<script>
import Panel from './Panel.vue';
import SidebarPanel from './SidebarPanel.vue';
import Handsontable from './Handsontable.vue';

export default {
  name: 'ReductionRoute',
  components: {
    SidebarPanel,
    Panel,
    Handsontable,
  },
  data() {
    return {
      tabs: [
        { name: 'Low', active: true, data: [] },
        { name: 'Med', active: false, data: [] },
        { name: 'High', active: false, data: [] },
      ],
      tableOptions: {
        minSpareRows: 10,
        className: 'htCenter',
        rowHeaders: true,
        colHeaders: ['Name', 'Sample Scattering', 'Sample Transmission', 'Background Scattering', 'Background Transmission'],
        columns: [
          {},
          {},
          {},
          {},
          {},
        ],
        height: 500,
        stretchH: 'all',
      },
    };
  },

  computed: {
    activeTab() {
      return this.tabs.find(d => d.active);
    },
  },

  methods: {
    setActiveTab(tab) {
      this.activeTab.active = false;
      tab.active = true;
    },

    addNewTab() {
      var newTab = {
        name: 'Tab ' + this.tabs.length,
        active: false,
        data: [],
      };

      this.tabs.push(newTab);
      this.setActiveTab(newTab);
    },
  },
};
</script>
