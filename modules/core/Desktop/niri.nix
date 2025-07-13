{ inputs, pkgs, ... }: {
  imports = [ inputs.niri-flake.nixosModules.niri ];
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
          binPath = "/run/current-system/sw/bin/niri -- --session";
        };
      };
    };
  };
  security.pam.services.swaylock = { };
}
