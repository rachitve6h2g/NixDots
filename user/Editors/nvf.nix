{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        useSystemClipboard = true;
        undoFile = {
          enable = true;
          path = lib.generators.mkLuaInline "os.getenv('XDG_DATA_HOME') .. '/nvf/undo'";
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind = {
            enable = true;
          };
        };

        syntaxHighlighting = true;

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        treesitter = {
          enable = true;
          context.enable = true;
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix = {
            enable = true;
            format = {
              enable = true;
              package = pkgs.nixfmt-rfc-style;
              type = "nixfmt";
            };
          };
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        maps = {
          insert = {
            "jj" = {
              action = "<Esc>";
              desc = "Map esc to jj";
            };
          };
        };

        options = {
          signcolumn = "yes";
          updatetime = 250;

          splitright = true;
          splitbelow = true;

          tabstop = 2;
          shiftwidth = 2;
          wrap = false;
        };
        extraPlugins = with pkgs.vimPlugins; {
          nvim-highlight-colors = {
            package = nvim-highlight-colors;
            setup = "require(\"nvim-highlight-colors\").setup({})";
            after = [ "lspkind" ];
          };
        };
      };
    };
  };
}
