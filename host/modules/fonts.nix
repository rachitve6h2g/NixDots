{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    packages =
      (with pkgs; [
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
      ])
      ++ (with pkgs.nerd-fonts; [jetbrains-mono iosevka]);
  };
}
