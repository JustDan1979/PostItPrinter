var path = require('path');

module.exports = {
  entry: './background.js',
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'background.js'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components|pdfkit)/,
        loader: 'babel-loader',
        query: {
          presets: ['env']
        }
      }
    ]
  }
}
