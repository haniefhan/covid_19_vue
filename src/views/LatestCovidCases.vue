<template>
  <div>
    <center>
      <h1>{{ country_rank }}</h1>
      <h2>{{ country_name }}</h2>
      <h3>Total Cases : {{ total_cases }}</h3>
      <table id="cases">
        <tr>
          <td>New Cases</td>
          <td>{{ new_cases }}</td>
        </tr>
        <tr>
          <td>Total Deaths</td>
          <td>{{ new_deaths }}</td>
        </tr>
        <tr>
          <td>Total Deaths</td>
          <td>{{ total_deaths }}</td>
        </tr>
        <tr>
          <td>Total Recovered</td>
          <td>{{ total_recovered }}</td>
        </tr>
      </table>
      <br />
      <br />
      <br />
      <select id="country_select" v-model="country_select">
        <option v-for="(country, key) in countries" :value="country" :key="key">
          {{ country }}
        </option>
      </select>
      <br />
      <br />
      <button @click="changeCountry">Change Country</button>
    </center>
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

<style>
table#cases {
  width: 300px;
}

table#cases td:nth-child(1) {
  font-weight: bold;
}

table#cases td:nth-child(2) {
  text-align: right;
}

select#country_select {
  padding: 5px;
  width: 300px;
}
</style>