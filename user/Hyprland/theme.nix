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

      # The Gruvbox Material Gtk theme
      # Uncomment below lines and comment others to use new
      # Themes
      #package = pkgs.gruvbox-gtk-theme.override {
      #  colorVariants = [ "dark" ];
      #  sizeVariants = [ "standard" ];
      #  themeVariants = [ "yellow" ];
      #  tweakVariants = [
      #    "black"
      #    "macos"
      #  ];
      #  iconVariants = [ "Dark" ];
      #};

      #name = "Gruvbox-Yellow-Dark";

      package = pkgs.magnetic-catppuccin-gtk.override {
        accent = [ "purple" ];
        shade = [ "dark" ];
        size = [ "standard" ];
        tweaks = [
          "black"
          "macos"
        ];
      };

      name = "Catppuccin-Purple-Dark";
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = [ "mocha" ];
        accent = [ "mauve" ];
      };
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

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
