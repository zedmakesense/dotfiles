local jdtls = require 'jdtls'

local home = vim.fn.expand '~'
local data = vim.fn.stdpath 'data'

local java_debug_jar = data .. '/java-debug/com.microsoft.java.debug.plugin-*.jar'

local config = {
    cmd = { 'jdtls' },
    root_dir = vim.fs.root(0, {
        'pom.xml',
        'build.gradle',
        'gradlew',
        'mvnw',
        '.git',
    }),

    init_options = {
        bundles = { java_debug_jar },
    },

    on_attach = function(_, _)
        jdtls.setup_dap { hotcodereplace = 'auto' }
    end,
}

jdtls.start_or_attach(config)
