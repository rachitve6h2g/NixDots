{pkgs, ...}: {
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme.override {
        color = "magenta";
      };

      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
  };
}
