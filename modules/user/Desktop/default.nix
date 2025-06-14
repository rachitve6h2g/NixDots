{
  # wayland.systemd.target = "graphical-session.target";
  imports = [
    # ./Hyprland
    ./Niri/
    # ./Sway

    ./battery-notifier.nix
    ./clipboard.nix
    ./mako.nix
    ./theme.nix
    ./wlsunset.nix
    ./wofi.nix
  ];
}
