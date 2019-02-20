/**
 * Gruntfile.js
 *
 * Run 'grunt' in shell to compile the documentation
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

  grunt.registerTask('default', 'shell:builddoc');
};
