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

    # ./qutebrowser
    ./zen-browser
  ];

  # Misc
  home.packages = with pkgs; [
    ansifilter
    bluetui
    figlet
    gthumb
    nurl # https://github.com/nix-community/nurl
    pavucontrol
    trash-cli
    (uget.override {
      aria2 = pkgs.aria2;
    })
    update-nix-fetchgit
    wgetpaste
  ];
}
