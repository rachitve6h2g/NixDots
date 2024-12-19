{
  imports = [
    ./fuzzel.nix
    ./hyprland.nix
    ./theme.nix
    ./waybar.nix
  ];

  # For Hyprland UWSM enviroment settings
  xdg.configFile."uwsm" = {
    source = ./uwsm_envs;
    recursive = true;
  };
}
