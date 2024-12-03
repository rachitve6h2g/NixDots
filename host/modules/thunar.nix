{pkgs, ...}: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # Xfconf needs to be enabled if not using xfce desktop manager
    xfconf.enable = true;
  };

  # Some services to enable for automounting
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
