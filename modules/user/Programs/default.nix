{ pkgs, ... }:
{
  imports = [
    ./bottom.nix
    ./btop.nix
    ./fastfetch.nix
    ./git.nix
    ./imv.nix
    ./mpv.nix
    ./newsboat.nix
    ./peaclock.nix
    ./qutebrowser.nix
    ./ripgrep.nix
    ./yazi
    ./ytdlp.nix
    ./zathura.nix
  ];

  # Misc
  home.packages = with pkgs; [
    trash-cli

    (uget.override {
      aria2 = pkgs.aria2;
    })

    bluetui
  ];
}
