{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.gruvbox-gtk-theme.override {
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        themeVariants = [ "yellow" ];
        tweakVariants = [
          "black"
          "macos"
        ];
        iconVariants = [ "Dark" ];
      };

      name = "Gruvbox-Yellow-Dark";
    };

    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };

    font = {
      package = pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      };
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };
}
