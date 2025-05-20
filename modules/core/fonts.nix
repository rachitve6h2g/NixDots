{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.comic-shanns-mono
    ];
  };
}
