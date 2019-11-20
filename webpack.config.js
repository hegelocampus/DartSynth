const webpack = require('webpack');
const path = require('path');

const config = {
  entry: './javascript/index.js',
  mode: "development",
  watch: true,
  output: {
    path: path.resolve(__dirname, 'web'),
    filename: 'bundle.js'
  }
};

module.exports = config;
