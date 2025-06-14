{ pkgs, lib, ... }:
{
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        swayidle
        swaylock-effects
      ];
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        sway = {
          prettyName = "Sway";
          comment = "Sway compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/sway";
        };
      };
    };
  };

  # For swaylock, configure thru home-manager
  security.pam.services.swaylock = { };
}
