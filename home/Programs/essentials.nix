{ pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
      package = pkgs.btop;
    };

    zathura = {
      enable = true;
    };

    bat = {
      enable = true;
    };
  };
}
