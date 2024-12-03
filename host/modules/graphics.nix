{
  pkgs,
  lib,
  inputs,
  ...
}: {
  hardware = {
    graphics = {
      enable = true;
      package = lib.mkForce inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
  };
}
