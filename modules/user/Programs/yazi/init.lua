-- For full-border plugin
require("full-border"):setup {
  type = ui.Border.ROUNDED, 
}

-- for git.yazi
require("git"):setup()
-- Modifications of color
th.git = th.git or {}
th.git.modified = ui.Style():fg("#9ccfd8")
th.git.deleted = ui.Style():fg("#eb6f92")
