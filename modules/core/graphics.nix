{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
      libvpl
      vaapiIntel
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
