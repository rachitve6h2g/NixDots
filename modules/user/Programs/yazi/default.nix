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
        mediainfo = pkgs.yaziPlugins.mediainfo;
        vcs-files = pkgs.yaziPlugins.vcs-files;
      };

      flavors = {
        rose-pine = (
          pkgs.stdenv.mkDerivation {
            name = "rose-pine-yazi";
            src = pkgs.fetchFromGitHub {
              owner = "rachitve6h2g";
              repo = "rose-pine-yazi";
              rev = "02d0644c1c29d5a6370f21ca831be877f039f5e9";
              hash = "sha256-pD6wVauBdc2H/4K7TnOXkFaCotnNhCsCEuZJYYpd0SQ=";
            };
            installPhase = ''
              mkdir $out
              cp -r $src/rose-pine-moon.yazi/* $out/
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

          prepend_preloaders = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }
            {
              mime = "application/subrip";
              run = "mediainfo";
            }
          ];

          prepend_previewrs = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }

            {
              mime = "application/subrip";
              run = "mediainfo";
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
