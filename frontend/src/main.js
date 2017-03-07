"use strict";

import Vue from 'vue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'

import router from './routes/router'
import App from './App.vue'

Vue.use(VueRouter);
Vue.use(Vuex);

Vue.component('app', App)

var store = new Vuex.Store({
  state: {
    count: 0
  },

  mutations: {
    increment: function (state) {
      state.count++
    }
  }
});

new Vue({
  el: '#app',
  router: router.router,

  data: {
    message: "Hello there",
    hotels: [
      "Big Hotel",
      "Little Hotel",
      "Posh Hotel"
    ]
  },
  render: function (createElement) {
    return createElement(App, {hotels: this.hotels})
  }
})
