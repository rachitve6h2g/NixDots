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
      selection-clipboard = "clipboard";
      statusbar-home-tilde = true;
      guioptions = "sv";
      scroll-page-aware = true;
      adjust-open = "width";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;
      recolor = "false";
      recolor-keephue = "false";
      vertical-center = true;
      synctex = true;
      zoom-step = 3;

      default-bg = lib.mkForce "#${config.lib.stylix.colors.base02}";
    };

    # TODO: Add emacs keybindings.
    mappings = {
       "[normal] <C-b>" = "scroll left";
       "[normal] <C-n>" = "scroll down";
       "[normal] <C-p>" = "scroll up";
       "[normal] <C-f>" = "scroll right";
       "[normal] <C-g>" = "abort";
       "[insert] <C-g>" = "abort";
    };
  };
}
