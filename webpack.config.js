'use strict';

const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  context: __dirname + "/app/assets/javascripts",

  entry: {
    application: ["./javascripts/application.js", "./stylesheets/application.css"]
  },

  output: {
    path: __dirname + "/public",
    filename: "javascripts/[name]-[hash].js",
  },

  module: {
    rules: [
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: "css-loader"
        })
      }
    ],

    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        },
      },
    ]
  },

  plugins: [
    new ExtractTextPlugin("stylesheets/[name]-[hash].css"),
  ],

};
