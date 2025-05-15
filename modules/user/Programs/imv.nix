{config, ...}: let
  theme = config.colorScheme.palette;
in {
  programs.imv = {
    enable = true;

    settings = {
      options = {
        background = "${theme.base00}";
        overlay_text_color = "${theme.base05}";
        overlay_background_color = "11111b";
      };
    };
  };
}
