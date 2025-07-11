{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;

    package = pkgs.mesa;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
      libvpl
    ];
  };
  environment.sessionVariables = {
    ANV_VIDEO_DECODE = 1;
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = 1;
  };

  boot.kernelParams = [
    "i915.force_probe=!a7a0"
    "xe.force_probe=a7a0"
  ];
}
