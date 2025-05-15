{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      libvpl
    ];
  };
  environment.sessionVariables = {
    ANVI_VIDEO_DECODE = 1;
    LIBVA_DRIVER_NAME = "iHD";
  };
}
