{ lib, ... }:
{
  # Configure it through home-manager
  services = {
    hypridle.enable = true;
  };

  # Configure thru home-manager
  programs = {
    dconf.enable = true;
    hyprlock.enable = true;

    hyprland = {
      enable = true;

      # All systemd options should be off
      withUWSM = true;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
  };

  # For hyprlock
  security.pam.services.hyprlock = { };

  # Refer https://nixos.org/manual/nixos/stable/options.html programs.uwsm.enable note
  services.dbus = {
    enable = true;
    implementation = lib.mkForce "broker";
  };
}
