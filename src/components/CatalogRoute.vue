<template>
    <div>
        <div class="col-xs-9">
            <panel>
                <span slot="title">Title</span>
                <div v-loading="$loadingRouteData">
                    <table class="table table-hover" v-if="status==='success'">
                        <thead>
                            <tr>
                                <th>Run</th>
                                <th>Title</th>
                                <th>Start</th>
                                <th>End</th>
                                <th>Duration</th>
                                <th>Proton</th>
                                <th>Total</th>
                                <th>Reduce</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="entry in data.entries">
                                <td>{{ entry.run }}</td>
                                <td>{{ entry.title }}</td>
                                <td v-time-ago="entry.start_time"></td>
                                <td v-time-ago="entry.end_time"></td>
                                <td v-time-diff="entry.duration"></td>
                                <td>{{ entry.proton_charge }}</td>
                                <td>{{ entry.total_counts }}</td>
                                <td>
                                    <a href="#!">
                                        <span class="glyphicon glyphicon-download-alt"></span>
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- pagination -->
                    <div class="text-center">
                        <ul class="pagination">
                            <li class="disabled">
                                <span>&laquo;</span>
                            </li>
                            <li class="active">
                                <span>1</span>
                            </li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
            </panel>
        </div>
        <div class="col-xs-3">
            <sidebar-panel>
                <span slot="title">Catalog</span>
                <div slot="body" class="list-group">
                    <a href="#" class="list-group-item ">see experiments</a>
                    <a href="#" class="list-group-item active">see IPTS-11255</a>
                    <a href="#" class="list-group-item">runs</a>
                    <a href="#" class="list-group-item disabled">this is disabled</a>
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
        return { status: 'pending', data: null, message: null };
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
