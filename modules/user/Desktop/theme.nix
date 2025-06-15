{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;

    # Use this when on Hyprland
    # package = pkgs.rose-pine-hyprcursor;
    # name = "rose-pine-hyprcursor";

    package = pkgs.rose-pine-hyprcursor;
    name = "BreezeX-RosePine-Linux";

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
