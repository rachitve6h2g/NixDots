{ pkgs, ... }:
{
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";

      plugins = {
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        lazygit = pkgs.yaziPlugins.lazygit;
        vcs-files = pkgs.yaziPlugins.vcs-files;
      };

      flavors = {
        rose-pine = (
          pkgs.fetchFromGitHub {
            owner = "rachitve6h2g";
            repo = "rose-pine.yazi";
            rev = "48ca87d7b0a88c01154d76ec6e8af6ed65372fdf";
            hash = "sha256-6jIp3rsxqbnAQgQfgVnZYjnki5QUnAv/6AVihDthE60=";
          }
        );
      };

      theme = {
        flavor = {
          dark = "rose-pine";
          light = "rose-pine";
        };
      };

      settings = {
        log = {
          enabled = false;
        };

        mgr = {
          show_hidden = true;
          sort_dir_first = true;
        };

        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
        };

      };
      keymap = {
        mgr = {
          prepend_keymap = [
            {
              on = [
                "g"
                "i"
              ];
              run = "plugin lazygit";
              desc = "run lazygit";
            }
            {
              on = [
                "g"
                "c"
              ];
              run = "plugin vcs-files";
              desc = "Show Git file changes";
            }
          ];
        };
      };

      initLua = builtins.readFile ./init.lua;
    };
  };
}
