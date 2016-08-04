#!/usr/bin/env node

var webpack = require('webpack')
var WebpackDevServer = require('webpack-dev-server')
var config = require('/app/webpack.config')

new WebpackDevServer(webpack(config), {
  publicPath: '/dist/',
  hot: true,
  inline: true,
  historyApiFallback: true,
  quiet: true,
}).listen(80, '0.0.0.0', function (err, result) {
  if (err) {
    console.log(err)
  }

  console.log('Listening at 0.0.0.0:80')
});
