{
  pkgs,
  lib,
  inputs,
  ...
}: let
  hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in {
  # for not building Hyprland for source
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Services
  services = {
    displayManager = {
      sessionPackages = [ hyprPackages.hyprland ];
      sddm = {
        enable = true;
        wayland.enable = true;
        sugarCandyNix = {
          enable = true;
          settings = {
            Background = lib.cleanSource ../../wallpapers/wall.jpg;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "left";
            HaveFormBackground = true;
            PartialBlur = true;
            Font = "Iosevka Nerd Font";
          };
        };
      };
    };
  };

  security.pam.services.hyprlock = {};
  programs = {
    hyprland = {
      enable = true;
      package = hyprPackages.hyprland.override {
        enableXWayland = false;
        legacyRenderer = false;
        withSystemd = true;
      };

      portalPackage = hyprPackages.xdg-desktop-portal-hyprland;
      # start with UWSM
      # Disable systemd in Home-Manger option
      # in 'wayland.windowManagers.hyprland.systemd.enable = false;'
      withUWSM = true;
    };

    # Use the ask password provided by gnome
    ssh = {
      enableAskPassword = true;
      askPassword = lib.mkForce "${pkgs.seahorse}/libexec/ssh-askpass";
    };
  };

  # For running electron apps in NixOS with wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
