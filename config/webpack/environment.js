const { environment } = require('@rails/webpacker');

const typescript = require('./loaders/typescript');
environment.loaders.prepend('typescript', typescript);

const aliases = require('./loaders/aliases');
environment.config.merge(aliases);


console.log(environment.config);
module.exports = environment;