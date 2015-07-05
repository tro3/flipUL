
module.exports = (grunt) ->
    grunt.initConfig(
        pkg: grunt.file.readJSON('package.json'),

        jshint:
          options: {jshintrc: true, force: true}
          all: ['gruntfile.js', 'src/**/*.js']

        coffeelint:
            options:
                max_line_length:
                    level: 'ignore'
            src: [ 'src/**/*.coffee' ]

        coffee:
            files:
                src: ['src/**/*.coffee', '!src/**/*.spec.coffee']
                ext: '.tmp.js'
                expand: true

        concat:
            src:
                src: ['src/**/*.js', '!src/**/*.spec.js']
                dest: 'build/flipUL.js'

        clean:
            tmp: ['src/**/*.tmp.js']

        ngAnnotate:
            'build/flipUL.js': ['build/flipUL.js']

        uglify:
          options:
            banner: """
            /*
            /* flipUL - Markdown components for Flip
            */
            
            """
          src:
            files:
              'build/flipUL.min.js': 'build/flipUL.js'
                    
        karma:
            options:
                configFile: 'karma.conf.js'
            build: {}
            compile:
                options:
                    files: [
                      'bower_components/angular/angular.js',
                      'bower_components/angular-mocks/angular-mocks.js',
                      'bower_components/marked/lib/marked.js',
                      'build/flipUL.min.js',
                      'src/**/*.spec.js',
                      'src/**/*.spec.coffee'
                    ]                       
    )
      
    grunt.loadNpmTasks('grunt-contrib-jshint')
    grunt.loadNpmTasks('grunt-coffeelint')
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-concat')
    grunt.loadNpmTasks('grunt-contrib-clean')
    grunt.loadNpmTasks('grunt-ng-annotate')
    grunt.loadNpmTasks('grunt-contrib-uglify')
    grunt.loadNpmTasks('grunt-karma')
    
    grunt.registerTask('check', ['jshint', 'coffeelint'])
    grunt.registerTask('build', ['coffee', 'concat', 'clean'])
    grunt.registerTask('compile', ['check', 'build', 'ngAnnotate', 'uglify', 'karma:compile'])
    
    grunt.registerTask('default', ['check', 'build', 'karma:build'])

