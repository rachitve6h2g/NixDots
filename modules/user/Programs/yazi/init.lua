-- For full-border plugin
require("full-border"):setup {
type = ui.Border.ROUNDED, 
}

-- for git.yazi
require("git"):setup()

-- For eza-preview
require("eza-preview"):setup({
level = 3,
follow_symlinks = false,
dereference = false,
})

