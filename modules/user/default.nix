{ osConfig, ... }:
{
  imports = [
    ./keymap.nix
    ./terminal.nix
    ./xdgsettings.nix

    ./Browsers
    ./Desktop
    ./Editors
    ./Media
    ./Programs
    ./Shell
  ];

  programs.nh = {
    enable = osConfig.programs.nh.enable;
    clean = osConfig.programs.nh.clean;
    flake = osConfig.programs.nh.flake;
  };
}
