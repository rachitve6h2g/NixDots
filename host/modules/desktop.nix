{
  pkgs,
  lib,
  inputs,
  ...
}: {

  # for not building Hyprland for source
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  security.pam.services.hyprlock = {};
  programs = {
    # Enabling Hyprland here for SDDM to recognize 
    # Also enable uswm (the recommended way to start hyprland
    uwsm = {
      enable = true;
      package = pkgs.uwsm;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
    hyprland = let 
      hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      package = hyprPackages.hyprland;
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
  environment = {
    systemPackages = with pkgs; [
      gnome-console
    ];
    gnome.excludePackages = with pkgs; [
      gedit
      gnome-tour
    ];
  };
}
