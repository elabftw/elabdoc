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
      }
    }
  });

  grunt.loadNpmTasks('grunt-shell');

  grunt.registerTask('doc', 'shell:builddoc');
};
