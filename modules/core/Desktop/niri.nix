{ pkgs, ... }: {
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri";
        };
      };
    };
  };
  security.pam.services.hyprlock = { };
}
