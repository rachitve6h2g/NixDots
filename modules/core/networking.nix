{ lib, ... }:
{
  networking = {
    # Refer this https://mynixos.com/nixpkgs/option/networking.hostName
    # For properly setting your hostname
    hostName = "hppavilion"; # Define your hostname.
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };
}
