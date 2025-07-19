{ pkgs, ... }: {
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    dbus.packages = with pkgs; [ gnome2.GConf ];

    gnome = {
      core-apps.enable = false;
      games.enable = false;
    };
  };

  # For detection of users
  environment.shells = with pkgs; [ zsh ];
}
