{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

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

  # set the LIBVA_DRIVER_NAME variable
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
