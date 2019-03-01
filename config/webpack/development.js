process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const typescript =  require('./loaders/typescript')
environment.loaders.append('typescript', typescript)

module.exports = environment.toWebpackConfig()
