{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      # The Gruvbox Material Gtk theme
      # Uncomment below lines and comment others to use new
      # Themes
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

      # package = pkgs.magnetic-catppuccin-gtk.override {
      #   accent = ["purple"];
      #   shade = "dark";
      #   size = "standard";
      #   tweaks = [
      #     "black"
      #     "macos"
      #   ];
      # };
      #
      # name = "Catppuccin-GTK-Purple-Dark";
    };

    # Catppuccin Papirus Icons
    # Uncomment to set the icon theme to catppuccin
    # iconTheme = {
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = "mauve";
    #   };
    #   name = "Papirus-Dark";
    # };
    #
    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };
    font = {
      package = pkgs.nerd-fonts.comic-shanns-mono;
      name = "ComicShannsMono Nerd Font";
      size = 12;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
