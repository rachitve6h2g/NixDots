{ config, ... }:
let
  theme = config.colorScheme.palette;
in
{
  programs.bottom = {
    enable = true;
    settings = {
      styles = {
        cpu = {
          all_entry_color = "#${theme.base06}";
          avg_entry_color = "#eba0ac"; # Maroon color
          cpu_core_colors = [
            "#${theme.base08}"
            "#${theme.base09}"
            "#${theme.base0A}"
            "#${theme.base0B}"
            "#74c7ec"
            "#cba6f7"
          ];
        };
      };
    };
  };
}
