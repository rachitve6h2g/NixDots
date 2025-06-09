{
  # wayland.systemd.target = "graphical-session.target";
  imports = [
    ./Hyprland
    # ./Sway

    ./clipboard.nix
    ./mako.nix
    ./theme.nix
    ./wlsunset.nix
    ./wofi.nix
  ];
}
