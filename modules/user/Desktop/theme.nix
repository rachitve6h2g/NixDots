{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.rose-pine-hyprcursor;
    name = "rose-pine-hyprcursor";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine";
    };

    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine";
    };
    font = {
      name = "sansserif";
      size = 12;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
