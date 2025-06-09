{ pkgs, ... }:
{
  imports = [
    ./bottom.nix
    ./btop.nix
    ./cmus.nix
    ./fastfetch.nix
    ./git.nix
    ./imv.nix
    ./mpv.nix
    ./newsboat.nix
    ./peaclock.nix
    ./ripgrep.nix
    ./yazi
    ./ytdlp.nix
    ./zathura.nix

    ./qutebrowser
  ];

  # Misc
  home.packages = with pkgs; [
    trash-cli

    (uget.override {
      aria2 = pkgs.aria2;
    })

    bluetui

    pavucontrol

    nurl # https://github.com/nix-community/nurl

    figlet
  ];
}
