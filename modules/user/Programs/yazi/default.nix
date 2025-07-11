{ pkgs, ... }:
let
  rose-pine = (
    pkgs.fetchFromGitHub {
      owner = "rachitve6h2g";
      repo = "rose-pine-yazi";
      rev = "02d0644c1c29d5a6370f21ca831be877f039f5e9";
      hash = "sha256-pD6wVauBdc2H/4K7TnOXkFaCotnNhCsCEuZJYYpd0SQ=";
    }
  );
in
{
  home.packages = with pkgs; [ mediainfo ]; # for mediainfo.yazi

  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";

      plugins = {
        bypass = pkgs.yaziPlugins.bypass;
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        glow = pkgs.yaziPlugins.glow;
        lazygit = pkgs.yaziPlugins.lazygit;
        mediainfo = pkgs.yaziPlugins.mediainfo;
        vcs-files = pkgs.yaziPlugins.vcs-files;
      };

      flavors = {
        rose-pine-moon = "${rose-pine}/rose-pine-moon.yazi";
        rose-pine-main = "${rose-pine}/rose-pine-main.yazi";
      };

      theme = {
        flavor = {
          dark = "rose-pine-main";
          light = "rose-pine-main";
        };
      };

      settings = {
        log = {
          enabled = true;
        };

        mgr = {
          show_hidden = true;
          sort_dir_first = true;
          sort_by = "natural";
          linemode = "size_and_mtime";
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

          prepend_previewers = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }

            {
              mime = "application/subrip";
              run = "mediainfo";
            }

            {
              name = "*.md";
              run = "glow";
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

            {
              on = [ "<C-e>" ];
              run = "seek 5";
            }

            {
              on = [ "<C-y>" ];
              run = "seek -5";
            }

            {
              on = [ "L" ];
              run = "plugin bypass";
              desc = "Recursively enter the child directory, skipping children with only a single subdirectory";
            }

            {
              on = [ "H" ];
              run = "plugin bypass reverse";
              desc = "Recursively enter the child directory, skipping children with only a single subdirectory";
            }
          ];
        };
      };

      initLua = builtins.readFile ./init.lua;
    };
  };
}
