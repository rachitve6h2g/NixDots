{
  pkgs,
  inputs,
  lib,
  ...
}: let
  yazi-plugins = inputs.yazi-plugins;
  yazi-flavors = inputs.yazi-flavors;
in {
  stylix.targets.yazi.enable = false; # For applying the theme from the official yazi-flavors repo
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";

      # Settings for yazi.toml
      settings = {
        manager = {
          show_hidden = true;
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
          use = lib.mkForce "catppuccin-mocha";
        };
      };
    };
  };
}
