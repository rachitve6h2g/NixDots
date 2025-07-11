{ lib, ... }:
{
  programs.dconf.enable = true;

  # Refer https://nixos.org/manual/nixos/stable/options.html programs.uwsm.enable note
  services.dbus = {
    enable = true;
    implementation = lib.mkForce "broker";
  };

  imports = [
    # ./displaymanager.nix
    # ./gnome.nix
    # ./hyprland.nix
    ./niri.nix
    # ./sway.nix
    ./xdgsettings.nix
    # ./xfce.nix
  ];
}
