{ pkgs, config, ... }:
let
  theme = config.colorScheme.palette;
in
{
  programs = {
    cmus = {
      enable = true;
      theme = "rose-pine";
    };

    cava = {
      enable = true;

      settings = {
        color = {
          background = "'#${theme.base00}'";
          gradient = 1;
          gradient_count = 6;
          gradient_color_1 = "'#${theme.base0B}'";
          gradient_color_2 = "'#${theme.base0C}'";
          gradient_color_3 = "'#${theme.base0D}'";
          gradient_color_4 = "'#${theme.base0A}'";
          gradient_color_5 = "'#${theme.base09}'";
          gradient_color_6 = "'#${theme.base08}'";
        };
      };
    };
  };

  # For cmus theming.
  xdg.configFile."cmus/rose-pine.theme".source = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/Iorvethe/cmus/refs/heads/main/src/rose-pine.theme";
      hash = "sha256-T6GSfDfoR6cjPIUdWW8pPahgh1echWBiX/ZBcx5LsU4=";
    }
  );
}
