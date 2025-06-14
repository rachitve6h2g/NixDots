{ pkgs, ... }: {
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri";
        };
      };
    };
  };
}
