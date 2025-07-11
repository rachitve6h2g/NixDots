{ inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./fontconfig.nix
    ./keymap.nix
    ./terminal.nix
    ./xdgsettings.nix

    ./Desktop
    ./Editors
    ./Programs
    ./Shell
  ];

  # TODO: see how to make a custom module for this
  # Instead of doing myTheme everywhere with a let binding
  # Use it as a custom module
  colorScheme = inputs.nix-colors.colorSchemes.rose-pine;
}
