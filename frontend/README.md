# GridVue frontend

> A base setup for Front End Projects at SiteMinder.

Initial configuration starts with the [vue-cli](https://github.com/vuejs/vue-cli) `simple-webpack` project, and then adding TypeScript compatability to it. Will grow this as needs arise.

## Build Setup

``` bash

# install yarn (optional)
npm install -g yarn

# install dependencies
yarn

# serve with hot reload at localhost:8080
yarnpkg run dev

# build for production with minification
yarnpkg run build

# run unit tests
yarnpkg run unit

# run e2e tests
yarnpkg run e2e

# run all tests
yarnpkg test

```

## To Do

- [ ] Add Vuex for State Management.
- [ ] Add ESLint support - pre-processing the TS. To confirm how this will work inside `*.vue` files.
- [ ] Add Karma Unit Testing support - pre-processing the TS. Tests will be written in JS.
- [ ] Add E2E testing with NightShade. This is Language Agnotic, but not going to write this in TS.
