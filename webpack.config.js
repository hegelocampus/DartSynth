const webpack = require('webpack');
const path = require('path');

const config = {
  entry: './javascript/index.ts',
  mode: "development",
  resolve: {
    extensions: [".ts", ".js"]
  },
  module: {
    rules: [
      { test: /\.(t|j)sx?$/, use: { loader: 'ts-loader' }, exclude: /node_modules/ },
      { enforce: "pre", test: /\.js$/, exclude: /node_modules/, loader: "source-map-loader" }
    ]
  },
  watch: true,
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'web'),
  },
  devtool: "source-map"
};

module.exports = config;
