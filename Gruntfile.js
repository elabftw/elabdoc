/**
 * Gruntfile.js
 *
 * Run 'grunt' in shell to compile javascript and css files
 *
 */
module.exports = function(grunt) {

  grunt.initConfig({
    shell: {
      builddoc: {
        command: 'cd doc; make html'
      },
      buildapi: {
        command: 'phpdoc run -d ../elabftw/app/classes -d ../elabftw/app/models -d ../elabftw/app/controllers -d ../elabftw/app/views -t api'
      },
    }
  });

  grunt.loadNpmTasks('grunt-shell');

  grunt.registerTask('doc', 'shell:builddoc');
  grunt.registerTask('api', 'shell:buildapi');
};
