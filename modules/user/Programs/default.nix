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
    ./yazi
    ./yt-dlp.nix
    ./zathura.nix
    ./zen.nix

    ./qutebrowser
  ];

  # Misc
  home.packages = with pkgs; [
    bluetui
    figlet
    nurl # https://github.com/nix-community/nurl
    pavucontrol
    trash-cli
    (uget.override {
      aria2 = pkgs.aria2;
    })
    wgetpaste
  ];
}
