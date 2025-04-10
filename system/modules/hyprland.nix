{
  # Configure it through home-manager
  services = {
    hypridle.enable = true;
  };

  # Configure thru home-manager
  programs = {
    hyprlock.enable = true;

    hyprland = {
      enable = true;

      # All systemd options should be off
      withUWSM = true;
    };
  };

  # For hyprlock
  security.pam.services.hyprlock = { };
}
