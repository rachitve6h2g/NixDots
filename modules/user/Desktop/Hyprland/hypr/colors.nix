{config, ...}: let
  theme = config.colorScheme.palette;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      "col.active_border" = "rgba(${theme.base0A}ff) rgba(${theme.base0B}ff) rgba(${theme.base08}ff) rgba(${theme.base0D}ff) 90deg";
      "col.inactive_border" = "rgba(${theme.base03}ff)";
    };

    misc = {
      background_color = "rgba(${theme.base00}ff)";
    };
  };
}
