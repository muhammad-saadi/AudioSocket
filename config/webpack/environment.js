const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.append('provide',
  new ProvidePlugin({
    s:'jquery',
    jQuery: 'jquery'
    popper: ['pepper.js', 'default']
  })
)

module.exports = environment
