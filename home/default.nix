{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./Programs
    ./Desktop

    ./xdgSettings.nix

    # Import nix-colors
    inputs.nix-colors.homeManagerModules.default
  ];

  # Set the colorscheme here
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home = {
    username = "chris";
    homeDirectory = "/home/chris";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
