<template>
  <div class="mt-20 p-6 rounded-lg bg-white mx-auto max-w-sm text-center shadow-md">
    <h1 class="mt-4 text-4xl font-bold">{{ country_rank }}</h1>
    <h2 class="mt-4 text-3xl font-bold">{{ country_name }}</h2>
    <h3 class="mt-4 text-xl text-red-400 font-bold tracking-wide">Total Cases : {{ total_cases }}</h3>
      <table class="mt-4 table w-64 mx-auto" id="cases">
        <tr>
          <td class="text-left font-semibold">New Cases</td>
          <td class="text-right tracking-wide">{{ new_cases }}</td>
        </tr>
        <tr>
          <td class="text-left font-semibold">Total Deaths</td>
          <td class="text-right tracking-wide">{{ new_deaths }}</td>
        </tr>
        <tr>
          <td class="text-left font-semibold">Total Deaths</td>
          <td class="text-right tracking-wide">{{ total_deaths }}</td>
        </tr>
        <tr>
          <td class="text-left font-semibold">Total Recovered</td>
          <td class="text-right tracking-wide">{{ total_recovered }}</td>
        </tr>
      </table>
    <select class="mt-10 w-64 p-1 border-gray-400 border-2 rounded-lg" id="country_select" v-model="country_select">
      <option v-for="(country, key) in countries" :value="country" :key="key">
        {{ country }}
      </option>
    </select>
    <button class="mt-6 px-4 py-2 rounded-lg bg-pink-500 text-white shadow-md font-semibold text-sm inline-block tracking-wider hover:bg-pink-400 focus:bg-pink-600" @click="changeCountry">Change Country</button>
  </div>
</template>

<script>
import axios from "axios";
import numeral from "numeral";

export default {
  name: "LatestCovidCases",
  data() {
    return {
      country_rank: "{Rank}",
      country_name: "{Country Name}",
      total_cases: "0",
      new_cases: "0",
      new_deaths: "0",
      total_deaths: "0",
      total_recovered: "0",
      country_select: "USA",
      countries: ["USA"],
    };
  },
  mounted() {
    this.getCountries(), this.getCovidLatestData()
  },
  methods: {
    async getCountries() {
      const url = "http://localhost:8000/get_countries"
      await axios.get(url).then((response) => {
        this.countries = response.data
        console.log(response.data)
      });
    },
    async getCovidLatestData() {
      const country_select = this.country_select
      const url =
        "http://localhost:8000/latest_covid_data?country_name=" + country_select
      
      this.resetValue()
      
      await axios.get(url).then((response) => {
        // console.log(response);
        this.country_rank = response.data.country_rank
        this.country_name = response.data.country_name
        this.total_cases = numeral(response.data.total_cases).format("0,0")
        this.new_cases = numeral(response.data.new_cases).format("0,0")
        this.new_deaths = numeral(response.data.new_deaths).format("0,0")
        this.total_deaths = numeral(response.data.total_deaths).format("0,0")
        this.total_recovered = numeral(response.data.total_recovered).format(
          "0,0"
        )
      })
    },
    changeCountry() {
      this.getCovidLatestData()
    },
    resetValue(){
      this.country_rank = '{Rank}'
      this.country_name = "{Country Name}"
      this.total_cases = "0"
      this.new_cases = "0"
      this.new_deaths = "0"
      this.total_deaths = "0"
      this.total_recovered = "0"
    }
  },
};
</script>