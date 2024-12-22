# See cachenix.nix in host-modules
# Contains yazi's cache substituters to not build it
# on the system...
{
  pkgs,
  inputs,
  lib,
  ...
}: let
  yazi-plugins = inputs.yazi-plugins;
  yazi-flavors = inputs.yazi-flavors;
  yazi-git = inputs.yazi.packages.${pkgs.system}.default;
in {
  programs = {
    yazi = {
      enable = true;
      package = yazi-git;
      enableZshIntegration = true;
      shellWrapperName = "y";

      # Settings for yazi.toml
      settings = {
        manager = {
          show_hidden = false;
        };

        opener = {
          edit = [
            {
              block = true;
              run = "vim \"$@\"";
            }
          ];

          play = [
            {
              run = "mpv \"$@\"";
              orphan = true;
              for = "unix";
            }
          ];
        };
      };

      # Set the flavors here
      flavors = {
        catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
      };

      # Use the theme above
      theme = {
        flavor = {
          dark = "catppuccin-mocha";
          light = "catppuccin-mocha";
        };
      };
    };
  };
}
