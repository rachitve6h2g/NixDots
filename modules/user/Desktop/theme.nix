{pkgs, config, ...}: {
  stylix = {
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons.override { folder-color = "purple"; };
      light = "Gruvbox-Plus-Dark";
      dark = config.stylix.iconTheme.light;
    };
  };
}
