{
  config,
  pkgs,
  ...
}:
let
  theme = config.colorScheme.palette;
in
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

      # Rose Pine Moon
      default-bg = "#232136";
      default-fg = "#e0def4";

      statusbar-fg = "#e0def4";
      statusbar-bg = "#59546d";

      inputbar-bg = "#817c9c";
      inputbar-fg = "#232136";

      notification-bg = "#817c9c";
      notification-fg = "#232136";

      notification-error-bg = "#817c9c";
      notification-error-fg = "#ea9a97";

      notification-warning-bg = "#817c9c";
      notification-warning-fg = "#f6c177";

      highlight-color = "rgba(0x3e, 0x8f, 0xb0, 0.5)";
      highlight-active-color = "rgba(0x9c, 0xcf, 0xd8, 0.5)";

      completion-bg = "#817c9c";
      completion-fg = "#9ccfd8";

      completion-highlight-fg = "#e0def4";
      completion-highlight-bg = "#9ccfd8";

      recolor-lightcolor = "#232136";
      recolor-darkcolor = "#e0def4";

      recolor = "false";
      recolor-keephue = "false";
    };
  };
}
