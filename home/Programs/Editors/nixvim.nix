{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  # For avoiding conflicting instacnces
  #home.sessionVariables = {
  #  EDITOR = lib.mkForce "nvim";
  #};

  # Disable stylix for nixvim
  stylix.targets.nixvim.enable = false;

  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      viAlias = true;
      vimAlias = true;
      colorschemes = {
        catppuccin = {
          enable = true;
          package = pkgs.vimPlugins.catppuccin-nvim;

          # Here goes settings
          settings = {
            disable_underline = true;
            flavor = "mocha";
            integrations = {
              cmp = true;
              gitsigns = true;
              mini = {
                enabled = true;
                indentscope_colors = "";
              };
              notify = true;
              nvimtree = true;
              treesitter = true;
            };
            styles = {
              booleans = [
                "bold"
                "italic"
              ];
              conditionals = [
                "bold"
              ];
            };
            transparent_background = true;
          };
        };
      };

      # Plugins
      plugins = {
        # lualine
        lualine = {
          enable = true;
        };

        # Bufferline
        bufferline = {
          enable = true;
        };

        mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            ai = {
              n_lines = 50;
              search_method = "cover_or_next";
            };
            icons = {
            };
            comment = {
              mappings = {
                comment = "<leader>/";
                comment_line = "<leader>/";
                comment_visual = "<leader>/";
                textobject = "<leader>/";
              };
            };
            diff = {
              view = {
                style = "sign";
              };
            };
            starter = {
              content_hooks = {
                "__unkeyed-1.adding_bullet" = {
                  __raw = "require('mini.starter').gen_hook.adding_bullet()";
                };
                "__unkeyed-2.indexing" = {
                  __raw = "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
                };
                "__unkeyed-3.padding" = {
                  __raw = "require('mini.starter').gen_hook.aligning('center', 'center')";
                };
              };
              evaluate_single = true;
              header = ''
                ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
                ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
                ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
                ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
                ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
              '';
              items = {
                "__unkeyed-1.buildtin_actions" = {
                  __raw = "require('mini.starter').sections.builtin_actions()";
                };
                "__unkeyed-2.recent_files_current_directory" = {
                  __raw = "require('mini.starter').sections.recent_files(10, false)";
                };
                "__unkeyed-3.recent_files" = {
                  __raw = "require('mini.starter').sections.recent_files(10, true)";
                };
                "__unkeyed-4.sessions" = {
                  __raw = "require('mini.starter').sections.sessions(5, true)";
                };
              };
            };
            surround = {
              mappings = {
                add = "gsa";
                delete = "gsd";
                find = "gsf";
                find_left = "gsF";
                highlight = "gsh";
                replace = "gsr";
                update_n_lines = "gsn";
              };
            };
          };
        };

        # Treesitter
        treesitter = {
          enable = true;
          gccPackage = pkgs.gcc;

          settings = {
            auto_install = true;
            ensure_installed = [
              "git_config"
              "gitignore"
            ];
          };
        };

        # Guess indent
        guess-indent = {
          enable = true;
          settings = {
            auto_cmd = false;
            filetype_exclude = [
              "markdown"
            ];
            buftype_exclude = [
              "help"
              "terminal"
              "nofile"
              "prompt"
            ];

            on_space_options = {
              expandtab = true;
              shiftwidth = "detected";
              softtabstop = "detected";
              tabstop = "detected";
            };

            on_tab_options = {
              expandtab = false;
            };

            override_editorconfig = true;
          };
        };
      };

      # Keymaps
      globals = {
        mapleader = " ";
        maplocalleader = " ";
        have_nerd_font = true;
      };

      opts = {
        number = true;
        relativenumber = true;
        mouse = "a";
        showmode = false;

        clipboard = {
          providers = {
            wl-copy.enable = false;
          };
          register = "unnamedplus";
        };

        # Enable break indent
        breakindent = true;

        undofile = true;

        # For ignoring case
        ignorecase = true;
        smartcase = true;

        # Keep signcolumn
        signcolumn = "yes";

        updatetime = 250;

        # Decrease mapped sequence wait time
        # Displays which-key popup sooner
        timeoutlen = 300;

        splitright = true;
        splitbelow = true;

        # Sets how neovim will display certain whitespace characters in the editor
        #  See `:help 'list'`
        #  See `:help 'listchars'`
        list = true;
        # NOTE: .__raw here means that this field is raw lua code
        listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

        # Preview substitutions live as you type
        inccommand = "split";

        # Show wchich line you are on
        cursorline = true;

        # Minimal number of screen
        scrolloff = 10;

        # See ':h hlsearch'
        hlsearch = true;

        # General settings
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        cursorcolumn = true;
        smartindent = true;
        softtabstop = 2;
        wildmenu = true;
        writebackup = false;
        wrap = false;
      };

      keymaps = [
        # Map esc key to jj
        {
          mode = ["i"];
          action = "<Esc>";
          key = "jj";
        }
      ];
    };
  };
}
