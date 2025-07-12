{pkgs, config, ...}: {
  stylix = {
    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };

    iconTheme = {
      enable = true;
      package = pkgs.rose-pine-icon-theme;
      light = "rose-pine";
      dark = config.stylix.iconTheme.light;
    };
  };
}
