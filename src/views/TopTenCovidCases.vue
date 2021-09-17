<template>
  <div>
    <center>
      <h1>{{ title }}</h1>
      <table id="topten">
        <thead>
          <th>Rank</th>
          <th>Country Name</th>
          <th>Total Cases</th>
          <th>New Cases</th>
          <th>New Deaths</th>
          <th>Total Deaths</th>
          <th>Total Recovered</th>
        </thead>
        <tbody>
          <tr v-for="data in topcases" :key="data.country_rank">
            <td>{{ data.country_rank }}</td>
            <td>{{ data.country_name }}</td>
            <td>{{ data.total_cases | formatNumber }}</td>
            <td>{{ data.new_cases  | formatNumber }}</td>
            <td>{{ data.new_deaths  | formatNumber }}</td>
            <td>{{ data.total_deaths  | formatNumber }}</td>
            <td>{{ data.total_recovered  | formatNumber }}</td>
          </tr>
        </tbody>
      </table>
    </center>
  </div>
</template>

<script>
import axios from "axios";
import numeral from "numeral";

export default {
  name: "TopTenCovidCases",
  data() {
    return {
      title: "Top Ten COVID-19 Cases",
      topcases: [],
    };
  },
  mounted() {
    this.TopTenCovidCases();
  },
  methods: {
    async TopTenCovidCases() {
      const url = "http://localhost:8000/top_ten_covid_case";
      await axios.get(url).then((response) => {
        this.topcases = response.data;
      });
    },
  },
  filters: {
    formatNumber: function (value) {
      return numeral(value).format("0,0");
    },
  },
};
</script>

<style>
table#topten {
  border-collapse: collapse;
  width: 90%;
}
table#topten td, table#topten th {
  border: 1px solid black;
  padding: 5px;
  text-align: right;
}
table#topten th {
  text-align: center;
}
table#topten td:nth-child(2) {
  text-align: left;
}
</style>
