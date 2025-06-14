{ pkgs, ...}: {
  imports = [
    ./fuzzel.nix
    ./hyprlock.nix
    ./swayidle.nix
    ./wallpaper.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    playerctl
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl" = {
    source = ./niri/config.kdl;
  };
}
