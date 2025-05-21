require("config.keybindings")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    vim.cmd([[%!nixfmt -qq]])
  end,
})
