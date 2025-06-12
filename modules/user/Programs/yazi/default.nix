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
          pkgs.stdenv.mkDerivation {
            name = "rose-pine-yazi";
            src = pkgs.fetchFromGitHub {
              owner = "rachitve6h2g";
              repo = "rose-pine.yazi";
              rev = "3db994e71b0f42dd1f713a544c917145560ce5bb";
              hash = "sha256-hWFlVcpUEOoeBqkWw7Lmd6vlegW+vJvQrz54xvAkxc8=";
            };

            installPhase = ''
              mkdir -p $out
              cp -r $src/* $out/
            '';
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
