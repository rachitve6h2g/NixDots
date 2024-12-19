{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.magnetic-catppuccin-gtk.override {
        accent = ["purple"];
        shade = "dark";
        size = "compact";
        tweaks = ["black" "float" "macos"];
      };
      name = "Catppuccin-GTK-Purple-Dark-Compact";
    };

    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Magenta-Dark";
    };

    font = {
      name = "JetBrains Nerd Font";
      size = 11;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
  };
}
