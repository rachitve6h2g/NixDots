{ pkgs, ... }:
{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
  };

  services = {
    gvfs = {
      enable = true;
    };
  };
}
