<template>
  <div class="mt-16 p-6 mx-auto max-w-3xl">
    <h1 class="text-3xl text-center text-red-400 font-semibold">{{ title }}</h1>
    <div class="mt-4 bg-white rounded-lg shadow-md p-6">
      <table id="topten" class="table-auto border-collapse w-full">
        <thead>
          <tr class="text-sm font-medium text-gray-700 text-center">
            <th class="px-2 py-2 bg-red-300">Rank</th>
            <th class="px-2 py-2 bg-red-300">Country Name</th>
            <th class="px-2 py-2 bg-red-300">Total Cases</th>
            <th class="px-2 py-2 bg-red-300">New Cases</th>
            <th class="px-2 py-2 bg-red-300">New Deaths</th>
            <th class="px-2 py-2 bg-red-300">Total Deaths</th>
            <th class="px-2 py-2 bg-red-300">Total Recovered</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="data in topcases" :key="data.country_rank" class="hover:bg-red-50 text-sm border-b border-red-300">
            <td class="px-2 py-3">{{ data.country_rank }}</td>
            <td class="px-2 py-3">{{ data.country_name }}</td>
            <td class="px-2 py-3">{{ data.total_cases | formatNumber }}</td>
            <td class="px-2 py-3 text-right">{{ data.new_cases | formatNumber }}</td>
            <td class="px-2 py-3 text-right">{{ data.new_deaths | formatNumber }}</td>
            <td class="px-2 py-3 text-right">{{ data.total_deaths | formatNumber }}</td>
            <td class="px-2 py-3 text-right">{{ data.total_recovered | formatNumber }}</td>
          </tr>
        </tbody>
      </table>
    </div>
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
