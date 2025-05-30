{ pkgs, ... }:
{
  xdg = {
    terminal-exec = {
      enable = true;
      package = pkgs.xdg-terminal-exec-mkhl;
      settings = {
        default = [
          "kitty.desktop"
        ];
        Hyprland = [
          "kitty.desktop"
        ];
        sway = [
          "kitty.desktop"
        ];
      };
    };
    icons = {
      enable = true;
    };
    menus.enable = true;
    sounds.enable = true;
  };
}
