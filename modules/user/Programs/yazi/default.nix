{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "55bf6996ada3df4cbad331ce3be0c1090769fc7c";
    hash = "sha256-v/C+ZBrF1ghDt1SXpZcDELmHMVAqfr44iWxzUWynyRk=";
  };

  yatline = pkgs.fetchFromGitHub {
    owner = "imsi32";
    repo = "yatline.yazi";
    rev = "2ecf715d33866e5f8a63af25f6a242821746ddb7";
    hash = "sha256-l4IrdALlgKd1USxE2+bD0Lkw3DgBoQDBxgxevrFhytU=";
  };
in
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
      plugins = {
        full-border = "${yazi-plugins}/full-border.yazi";
        vcs-files = "${yazi-plugins}/vcs-files.yazi";
        smart-enter = "${yazi-plugins}/smart-enter.yazi";
        git = "${yazi-plugins}/git.yazi";
        toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
        yatline = "${yatline}/";
        yatline-gruvbox-material = (
          pkgs.fetchFromGitHub {
            owner = "imsi32";
            repo = "yatline-gruvbox-material.yazi";
            rev = "8e18dad0b398089e47c578b0a696df3733b3e376";
            hash = "sha256-J9koKA4g8yGKxjIWTlLJiuyJMmhXt6n7Xt/PCBshOEg=";
          }
        );
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
        };
      };

      initLua = builtins.readFile ./init.lua;
    };
  };
}
