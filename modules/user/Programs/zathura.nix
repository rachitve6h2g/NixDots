{
  pkgs,
  config,
  ...
}: let
  theme = config.colorScheme.palette;
in {
  programs.zathura = {
    enable = true;

    package = pkgs.zathura.override {
      useMupdf = true;
      # TODO: Customize here
      plugins = [pkgs.zathuraPkgs.zathura_cb];
    };

    options = {
      font = "ComicShannsMono Nerd Font Mono 10";
      selection-notification = true;
      guioptions = "sv";
      scroll-page-aware = true;
      statusbar-home-tilde = true;
      recolor = true;
      adjust-open = "width";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      default-fg = "#${theme.base05}";
      default-bg = "#${theme.base01}cc";

      completion-bg = "#${theme.base02}";
      completion-fg = "#${theme.base05}";
      completion-highlight-bg = "#${theme.base04}";
      completion-highlight-fg = "#${theme.base05}";
      completion-group-bg = "#${theme.base02}";
      completion-group-fg = "#${theme.base0D}";

      statusbar-fg = "#${theme.base05}";
      statusbar-bg = "#${theme.base02}";

      notification-bg = "#${theme.base02}";
      notification-fg = "#${theme.base05}";
      notification-error-bg = "#${theme.base02}";
      notification-error-fg = "#${theme.base08}";
      notification-warning-bg = "#${theme.base02}";
      notification-warning-fg = "#fae3b0";

      inputbar-fg = "#${theme.base05}";
      inputbar-bg = "#${theme.base02}";

      recolor-lightcolor = "#${theme.base00}";
      recolor-darkcolor = "#${theme.base05}";

      index-fg = "#${theme.base05}";
      index-bg = "#${theme.base00}";
      index-active-fg = "#${theme.base05}";
      index-active-bg = "#${theme.base02}";

      render-loading-bg = "#${theme.base00}";
      render-loading-fg = "#${theme.base05}";

      highlight-color = "#57526880";
      highlight-fg = "#f5c2e780";
      highlight-active-color = "#f5c2e780";
    };
  };
}
