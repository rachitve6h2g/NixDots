{pkgs, ...}: {
  # Qt settings
  #qt = {
  #  enable = true;
  #  platformTheme = "gnome";
  #  style = "adwaita-dark";
  #};

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ../../wallpapers/totoro.jpg;
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # Enable the home-manager itegration
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };

    # Manage fonts here
    fonts = {
      monospace = {
        name = "Iosevka Nerd Font Mono";
        package = pkgs.nerd-fonts.iosevka;
      };
    };

    # Target specific
    targets = {
      nixvim.enable = false; # For use with the home-manager module only
    };
  };
}
