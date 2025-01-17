{ pkgs, ... }:
{
  services.kdeconnect = {
    enable = true;
    package = pkgs.plasma5Packages.kdeconnect-kde;
  };
}
