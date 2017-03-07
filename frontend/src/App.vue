<template>
  <div id="app">
    <ul>
      <li>Nav:</li>
      <li><router-link to="/">Go To Home</router-link></li>
      <li><router-link to="/about">About Us</router-link></li>
    </ul>
    <router-view></router-view>

    <div>
      <h2>Hotels</h2>
      <div id="hotels-list">
        <ul>
          <!-- <li v-for="hotel in hotels">
            {{hotel}}
          </li> -->
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['hotels'],
  render: function(h) {

  },
  created: function () {
    console.warn(`message is: '${this.hotels}'`)
  },

  data() {
    return {
      message: 'Hi! Let\'s have some fun.',
      hotels: []
    }
  }
}
</script>

<style lang="scss">
  $highlight-color: #42b983;

  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: $highlight-color;
  }
</style>
