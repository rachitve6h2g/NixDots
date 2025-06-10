{ pkgs, ... }: let
  rose-pine-btop = (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rose-pine/btop/refs/heads/main/rose-pine.theme";
    hash = "sha256-CIZ1OHsLNmXwQkrGslB0jezY8jh6Cs+CG8j0eoDP0sY=";
  });
in {
  programs.btop = {
    enable = true;
    themes = {
      rose-pine = ''${rose-pine-btop}'';
    };
    settings = {
      color_theme = "rose-pine";
      theme_background = false;
      vim_keys = true;
      rounded_corners = true;
    };
  };

  # IN locale doesn't have utf-8 encoding.
  programs.zsh.shellAliases.btop = "btop --force-utf";
}
