const webpack            = require('webpack')
const path               = require('path')
const ExtractTextPlugin  = require('extract-text-webpack-plugin')
const CleanWebpackPlugin = require('clean-webpack-plugin')

module.exports = {
  entry: [
    'webpack-dev-server/client?http://localhost:8080',
    'webpack/hot/only-dev-server',
    './src/index.jsx'
  ],
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['.js', '.json', '.jsx'],
    modules: [
      path.join(__dirname, 'src'),
      "node_modules"
    ]
  },
  devtool: '#source-map',
  module: {
    noParse: /node_modules\/localforage\/dist\/localforage.js/,
    rules: [
      {
        test: /\.jsx?$/,
        include: path.join(__dirname, 'src'),
        use: 'babel-loader'
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({ fallbackLoader: 'style-loader', loader: ['css-loader', 'sass-loader' ]})
      },
      { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,   use: "url-loader?limit=10000&mimetype=application/font-woff&name=/css/fonts/[name].[ext]" },
      { test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/,  use: "url-loader?limit=10000&mimetype=application/font-woff&name=/css/fonts/[name].[ext]" },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,    use: "url-loader?limit=10000&mimetype=application/octet-stream&name=/css/fonts/[name].[ext]" },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,    use: "file-loader?name=/css/fonts/[name].[ext]" },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,    use: "url-loader?limit=10000&mimetype=image/svg+xml&name=/css/fonts/[name].[ext]" }
    ]
  },
  devServer: {
    contentBase: './dist',
    hot: true,
    // inline: true,
    historyApiFallback: true
  },
  plugins: [
    new CleanWebpackPlugin(['dist'], {
      exclude: ['images', 'index.html', 'favicon.ico', '_redirects']
    }),
    new webpack.optimize.CommonsChunkPlugin({name: 'common', filename: 'common.js'}),
    new ExtractTextPlugin({filename: 'css/styles.css', allChunks: true}),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('development'),
        'socketURI': JSON.stringify('http://localhost:3000/')
      }
    })
  ]
}
