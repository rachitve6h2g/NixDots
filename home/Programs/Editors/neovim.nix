{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nil
      luajitPackages.lua-lsp
      typescript-language-server
    ];

    # Lua configuration can be sourced like so
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/keymap.lua}
      ${builtins.readFile ./nvim/plugin/other.lua}
    '';

    # Adding plugins
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/nvim-tree.lua;
      }

      {
        plugin = nvim-surround;
        type = "lua";
        config =
          /*
          lua
          */
          "require(\"nvim-surround\").setup({})";
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-material-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/gruvbox.lua;
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/telescope.lua;
      }

      {
        plugin = indent-blankline-nvim-lua;
        type = "lua";
        config =
          /*
          lua
          */
          "require(\"ibl\").setup()";
      }

      neodev-nvim
      telescope-fzf-native-nvim
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      lualine-nvim
      nvim-web-devicons

      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.c
          p.nix
          p.lua
          p.bash
          p.json
          p.jsonc
          p.css
          p.scss
          p.typescript
        ]);
        type = "lua";
        config = builtins.readFile ./nvim/plugin/treesitter.lua;
      }

      {
        plugin = nvim-highlight-colors;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/csscolors.lua;
      }

      {
        plugin = lspkind-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugin/lspkind.lua;
      }
      vim-nix

      {
        plugin = plenary-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          "local async = require (\"plenary.async\")";
      }
    ];
  };
}
