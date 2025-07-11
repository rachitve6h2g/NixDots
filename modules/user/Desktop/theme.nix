{pkgs, config, ...}: {
  home.pointerCursor = {
    gtk.enable = true;

    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";

    size = 32;

    dotIcons.enable = false;
  };

  gtk = {
    enable = true;

    cursorTheme = {
      name = config.home.pointerCursor.name;
      package = config.home.pointerCursor.package;
      size = config.home.pointerCursor.size;
    };

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
