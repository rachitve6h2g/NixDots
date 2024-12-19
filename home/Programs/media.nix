{pkgs, ...}: {
  programs = {
    imv = {
      enable = true;
      package = pkgs.imv;
    };

    # MPV player
    mpv = {
      enable = true;
      package = pkgs.mpv;
      config = {
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
      };
    };
  };
}
