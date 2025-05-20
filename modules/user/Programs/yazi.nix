{ pkgs, ... }:
{
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";
      # Refer https://yazi-rs.github.io/docs/installation/
      # package = pkgs.yazi; # Comment if using the git package

      flavors =
        let
          gruvbox-yazi = (
            pkgs.stdenv.mkDerivation {
              pname = "yazi-flavor-gruvbox";
              version = "24.4.25";
              src = pkgs.fetchFromGitHub {
                owner = "bennyyip";
                repo = "gruvbox-dark.yazi";
                rev = "91fdfa70f6d593934e62aba1e449f4ec3d3ccc90";
                hash = "sha256-RWqyAdETD/EkDVGcnBPiMcw1mSd78Aayky9yoxSsry4=";
              };
              installPhase = ''
                mkdir -p $out
                cp -r $src/* $out/
              '';
            }
          );
        in
        {
          gruvbox-dark = gruvbox-yazi;
        };

      theme = {
        flavor = {
          dark = "gruvbox-dark";
          light = "gruvbox-dark";
        };
      };

      # Refer https://github.com/nix-community/home-manager/issues/7088
      # and https://github.com/nix-community/home-manager/pull/7090
      plugins =
        let
          eza-preview-yazi = (
            pkgs.stdenv.mkDerivation {
              pname = "yaziPlugins-eza-preview";
              version = "unstable-2025-02-18";

              src = pkgs.fetchFromGitHub {
                owner = "sharklasers996";
                repo = "eza-preview.yazi";
                rev = "7ca4c2558e17bef98cacf568f10ec065a1e5fb9b";
                hash = "sha256-ncOOCj53wXPZvaPSoJ5LjaWSzw1omHadKDrXdIb7G5U=";
              };

              buildPhase = ''
                mkdir $out
                cp $src/* $out
                mv $out/init.lua $out/main.lua
              '';
            }
          );
        in
        {
          full-border = pkgs.yaziPlugins.full-border;
          vcs-files = pkgs.yaziPlugins.vcs-files;
          smart-enter = pkgs.yaziPlugins.smart-enter;
          git = pkgs.yaziPlugins.git;
          toggle-pane = pkgs.yaziPlugins.toggle-pane;
          eza-preview = eza-preview-yazi;
        };

      keymap = {
        manager = {
          prepend_keymap = [
            {
              on = "T";
              run = "plugin toggle-pane max-preview";
              desc = "Show or hide the preview pane";
            }

            {
              on = "l";
              run = "plugin smart-enter";
              desc = "Enter the child directory, or open the file";
            }

            # For vcs-files.yazi
            {
              on = [
                "g"
                "c"
              ];
              run = "plugin vcs-files";
              desc = "Show Git File changes";
            }
          ];
        };
      };

      settings = {
        plugin = {
          prepend_fetchers = [
            # For git.yazi
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
            # For git.yazi
          ];

          prepend_previewers = [
            {
              name = "*/";
              run = "eza-preview";
            }
          ];
        };
      };

      initLua = # lua
        ''
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
        '';
    };
  };
}
