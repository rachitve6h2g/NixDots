{ pkgs, ... }:
{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    nerd-fonts.zed-mono
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "ZedMono Nerd Font"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
    };
  };
}
