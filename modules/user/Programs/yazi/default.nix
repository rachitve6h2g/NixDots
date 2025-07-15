{ pkgs, ... }:
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

      settings = {
        log = {
          enabled = true;
        };

        mgr = {
          ratio = [
            1
            4
            3
          ];
          show_hidden = true;
          show_symlink = true;
          sort_reverse = false;
          sort_sensitive = true;
          sort_dir_first = true;
          sort_by = "natural";
          linemode = "size_and_mtime";
        };

        preview = {
          image_filter = "lanczos3";
          image_quality = 90;
          tab_size = 1;
          max_width = 600;
          max_height = 900;
          cache_dir = "";
          ueberzug_scale = 1;
          ueberzug_offset = [
            0
            0
            0
            0
          ];
        };

        tasks = {
          micro_workers = 5;
          macro_workers = 10;
          bizarre_retry = 5;
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

            # Keybindings like emacs
            {
              on = "<C-n>";
              run = "arrow next";
              desc = "Next File";
            }
            {
              on = "<C-p>";
              run = "arrow prev";
              desc = "Previous file";
            }
            {
              on = "<C-b>";
              run = "leave";
              desc = "Back to parent directory";
            }
            {
              on = "<C-f>";
              run = "enter";
              desc = "Enter the child directory";
            }

            {
              on = [ "<C-x>" "c" ];
              run = "quit";
              desc = "Quit the process";
            }

            {
              on = [ "<C-x>" "h" ];
              run = "help";
              desc = "Open help";
            }

            {
              on = [ "<C-x>" "k" ];
              run = "close";
              desc = "Close the current tab, or quit if it's last";
            }
          ];
        };
      };

      initLua = builtins.readFile ./init.lua;
    };
  };
}
