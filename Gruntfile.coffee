module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    sass:
      options:
        includePaths: ['bower_components/foundation/scss']
      dist:
        files:
          'css/app.css': 'scss/app.scss'
    coffee:
      options:
        join: true
        bare: true
      dist:
        files:
          'js/app.js': 'coffee/app.coffee'
    watch:
      grunt:
        files: ['Gruntfile.coffee']
      sass:
        files: 'scss/**/*.scss'
        tasks: ['sass']
      coffee:
        files: 'coffee/**/*.coffee'
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', ['sass', 'coffee']
  grunt.registerTask 'default', ['build', 'watch']
