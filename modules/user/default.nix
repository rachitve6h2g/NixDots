{ config, inputs, pkgs, ... }:
{
  imports = [
    ./fontconfig.nix
    ./keymap.nix
    ./terminal.nix
    ./xdgsettings.nix

    ./Desktop
    ./Editors
    ./Programs
    ./Shell
  ];
}
