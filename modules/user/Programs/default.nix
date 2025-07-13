{ pkgs, ... }:
{
  imports = [
    ./bottom.nix
    ./btop.nix
    ./fastfetch.nix
    ./git.nix
    ./imv.nix
    ./newsboat.nix
    ./peaclock.nix
    ./yazi
    ./yt-dlp.nix
    ./zathura.nix

    ./media
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
