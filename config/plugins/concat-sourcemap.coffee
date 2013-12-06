module.exports = (lineman) ->
  baseConfig = lineman.config.application

  config:
    loadNpmTasks: baseConfig.loadNpmTasks.concat("grunt-concat-sourcemap")

    removeTasks:
      common: baseConfig.removeTasks.common.concat("concat")

    appendTasks:
      common: baseConfig.appendTasks.common.concat("concat_sourcemap")

    concat_sourcemap:
      options:
        sourcesContent: true

      js:
        src: [
          "<%= files.js.vendor %>"
          "<%= files.template.generated %>"
          "<%= files.js.app %>"
          "<%= files.coffee.generated %>"
        ]
        dest: "<%= files.js.concatenated %>"

      spec:
        src: [
          "<%= files.js.specHelpers %>"
          "<%= files.coffee.generatedSpecHelpers %>"
          "<%= files.js.spec %>"
          "<%= files.coffee.generatedSpec %>"
        ]
        dest: "<%= files.js.concatenatedSpec %>"

      css:
        src: [
          "<%= files.less.generatedVendor %>"
          "<%= files.sass.generatedVendor %>"
          "<%= files.css.vendor %>"
          "<%= files.less.generatedApp %>"
          "<%= files.sass.generatedApp %>"
          "<%= files.css.app %>"
        ]
        dest: "<%= files.css.concatenated %>"

    watch:
      js:
        files: ["<%= files.js.vendor %>", "<%= files.js.app %>"]
        tasks: ["concat_sourcemap:js"]
      coffee:
        files: "<%= files.coffee.app %>"
        tasks: ["coffee", "concat_sourcemap:js"]
      jsSpecs:
        files: ["<%= files.js.specHelpers %>", "<%= files.js.spec %>"]
        tasks: ["concat_sourcemap:spec"]
      coffeeSpecs:
        files: ["<%= files.coffee.specHelpers %>", "<%= files.coffee.spec %>"]
        tasks: ["coffee", "concat_sourcemap:spec"]
      css:
        files: ["<%= files.css.vendor %>", "<%= files.css.app %>"]
        tasks: ["concat_sourcemap:css"]
      less:
        files: ["<%= files.less.vendor %>", "<%= files.less.app %>"]
        tasks: ["less", "concat_sourcemap:css"]
      sass:
        files: ["<%= files.sass.vendor %>", "<%= files.sass.app %>"]
        tasks: ["sass", "concat_sourcemap:css"]
      handlebars:
        tasks: ["handlebars", "concat_sourcemap:js"]
      underscore:
        tasks: ["jst", "concat_sourcemap:js"]
