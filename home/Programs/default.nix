{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./essentials.nix
    ./git.nix
    ./kdeconnect.nix
    ./media.nix
    ./shell.nix
    ./terminal.nix

    ./Editors
    ./Yazi
  ];

  # Misc pakcges go here
  home = {
    packages = with pkgs; [
      # For bluetooth control
      bluetuith
      qbittorrent

    ];
  };
}
