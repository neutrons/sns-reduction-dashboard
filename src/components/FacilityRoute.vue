<template>
  <div v-show="!$loadingRouteData">
    <p>Count: {{ count }}</p>
    <p>Next: <a :href="next">{{ next }}</a></p>
    <p>Previous: <a :href="previous">{{ previous }}</a></p>
    <p>Results:</p>
    <table border="1">
      <thead>
        <th>url</th>
        <th>pk</th>
        <th>name</th>
        <th>instruments</th>
      </thead>
      <tbody>
        <tr v-for="result in results">
          <td><a :href="result.url">{{result.url}}</a></td>
          <td>{{result.pk}}</td>
          <td>{{result.name}}</td>
          <td>
            <ul>
              <li v-for="inst in result.instruments"><a :href="inst">{{inst}}</a></li>
            </ul>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { facility } from '../resource';

export default {
  name: 'FacilityRoute',
  data() {
    return { count: null, next: null, previous: null, results: null };
  },
  route: {
    data({ next }) {
      facility.get().then(response => {
        next(response.json());
      });
    },
  },
};
</script>
