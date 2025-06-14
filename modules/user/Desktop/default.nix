{
  # wayland.systemd.target = "graphical-session.target";
  imports = [
    # ./Hyprland
    ./Niri
    # ./Sway

    ./clipboard.nix
    ./mako.nix
    ./theme.nix
    ./wlsunset.nix
    # ./wofi.nix
  ];
}
