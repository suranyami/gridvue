"use strict";

import VueRouter from 'vue-router'

import HotelList from '../components/HotelList.vue'
import About from '../components/About.vue'

const routes = [
  {path: '/', component: HotelList},
  {path: '/about', component: About},
]

const router = new VueRouter({
  routes: routes
})

export default {
  router
}
