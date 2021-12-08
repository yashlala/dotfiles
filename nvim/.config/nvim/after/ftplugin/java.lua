-- TODO: Can we set up a default file width before vim sleuth kicks in? 
--
-- Let's set up a jdtls server using nvim-jdtls. 

-- TODO: jdtls refuses to set itself up on our computer. 
-- Figure it out later. 

--[[
local project_root = require('jdtls.setup').find_root(
  { '.git', 'mvnw', '.gradle', 'gradlew' })

local config = {
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = project_root,

  cmd = {
    'java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- NOTE: Keep these updated and pointing to the latest version of the jdtls launcher!
    -- We might set up a script to do this automatically later? 
    '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/usr/share/java/jdtls/config_linux',

    -- See `data directory configuration` section in the README
    '-data', project_root .. 'jdtls-data-dir'
  },


  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = { }
  }
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
-]]
