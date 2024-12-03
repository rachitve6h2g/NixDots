{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      nerd-fonts.iosevka
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {

  stylix = {
    enable = true;
    autoEnable = true;

    # General font settings
    # fonts = {
    #   # set monospace for Nerd Fonts
    #   monospace = {
    #     name = "Noto Sans Mono";
    #     package = pkgs.nerd-fonts.iosevka;
    #   };

    #     serif = {
    #         name = "Noto Serif";
    #         package = pkgs.noto-fonts;
    #     };

    #     sansSerif = {
    #         name = "Noto Sans";
    #         package = pkgs.noto-fonts;
    #     };

    #     emoji = {
    #         name = "Noto Color Emoji";
    #         package = pkgs.noto-fonts-color-emoji;
    #     };

    #   # Desktop font size managed here
    #   sizes = {
    #     desktop = 10;
    #     applications = 12;
    #     terminal = 15;
    #     popups = 10;
    #   };
    # };
  };
}
