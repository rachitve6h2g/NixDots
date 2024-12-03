{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./essentials.nix
    ./git.nix
    ./media.nix
    ./shell.nix
    ./terminal.nix
    ./yazi.nix

    ./Editors
  ];

  # Misc pakcges go here
  home = {
    packages = with pkgs; [
      # For bluetooth control
      bluetuith
    ];
  };
}
