{ inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./sh.nix
    ./terminal.nix
    ./xdgsettings.nix

    ./neovim
    ./Hyprland
    ./Programs
  ];

  # TODO: see how to make a custom module for this
  # Instead of doing myTheme everywhere with a let binding
  # Use it as a custom module
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;
}
