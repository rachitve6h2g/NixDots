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
    };
  };
}
