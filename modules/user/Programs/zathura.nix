{
  pkgs,
  config,
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
      recolor = true;
      recolor-keephue = false;
      adjust-open = "width";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      default-bg = "#${theme.base00}";
      default-fg = "#${theme.base05}";

      completion-bg = "#${theme.base03}";
      completion-fg = "#${theme.base0A}";

      completion-highlight-bg = "#${theme.base0A}";
      completion-highlight-fg = "#${theme.base02}";

      completion-group-bg = "#${theme.base02}";
      completion-group-fg = "#${theme.base0D}";

      statusbar-fg = "#${theme.base05}";
      statusbar-bg = "#555169";

      notification-bg = "#${theme.base05}";
      notification-fg = "#555169";

      notification-error-bg = "#${theme.base09}";
      notification-error-fg = "#555169";

      notification-warning-bg = "#${theme.base0A}";
      notification-warning-fg = "#555169";

      inputbar-fg = "#${theme.base05}";
      inputbar-bg = "#${theme.base03}";

      recolor-lightcolor = "#${theme.base00}";
      recolor-darkcolor = "#${theme.base05}";

      index-fg = "#${theme.base05}";
      index-bg = "#${theme.base00}";

      index-active-fg = "#${theme.base05}";
      index-active-bg = "#${theme.base02}";

      render-loading-bg = "#${theme.base00}";
      render-loading-fg = "#${theme.base05}";

      highlight-color = "rgba(0xeb, 0xbc, 0xba, 0.5)";
      highlight-active-color = "rgba(0xeb, 0x6f, 0x92, 0.5)";

      include = "hello";
    };
  };
}
