{
  pkgs,
  inputs,
  ...
}: let
  yazi-plugins = inputs.yazi-plugins;
  yazi-flavors = inputs.yazi-flavors;
in {
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
          use = "catppuccin-mocha";
        };
      };
    };
  };
}
