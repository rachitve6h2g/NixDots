{ pkgs, ... }: {
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    dbus.packages = with pkgs; [ gnome2.GConf ];
  };

  # For detection of users
  environment.systemPackages = with pkgs; [ zsh ];
}
