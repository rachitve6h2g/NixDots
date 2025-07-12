{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.zathura = {
    enable = true;

    package = pkgs.zathura.override {
      useMupdf = true;
    };

    options = {
      font = "monospace 10";
      selection-notification = true;
      guioptions = "sv";
      scroll-page-aware = true;
      statusbar-home-tilde = true;
      adjust-open = "width";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;
      recolor = "false";
      recolor-keephue = "false";

      default-bg = lib.mkForce "#${config.lib.stylix.colors.base02}";
    };
  };
}
