{ inputs, lib, ... }:
{
  imports = [ inputs.sddm-sugar-candy-nix.nixosModules.default ];

  nixpkgs.overlays = [
    inputs.sddm-sugar-candy-nix.overlays.default
  ];

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
        settings = {
          General.DisplayServer = "wayland";
        };
        sugarCandyNix = {
          enable = true;
          settings = {
            Background = lib.cleanSource ./platform.jpg;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "left";
            HaveFormBackground = true;
            PartialBlur = true;
          };
        };
      };
      defaultSession = "niri-uwsm";
    };
  };
}
