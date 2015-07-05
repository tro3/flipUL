// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

module.exports = function(config) {
  config.set({

    basePath: '',

    frameworks: ['mocha', 'chai'],

    preprocessors: {
      '*/.html': [],
      '**/*.coffee': ['coffee']
    },

    files: [
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'build/flipUL.js',
      'src/**/*.spec.js',
      'src/**/*.spec.coffee'
    ],

    exclude: [],

    reporters: ['mocha'],

    port: 9878,

    logLevel: config.LOG_INFO,

    autoWatch: false,

    browsers: ['Chrome'],

    singleRun: true
  });
};