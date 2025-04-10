{
  inputs,
  config,
  userSettings,
  ...
}:
{
  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + config.home.username;
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./sh.nix
    ./terminal.nix

    ./Editors
    ./Hyprland
    ./Programs
  ];
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
}
