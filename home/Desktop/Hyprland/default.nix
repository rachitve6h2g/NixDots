{
  imports = [
    ./theme.nix
    ./HyprEssenceMain
    ./AGS
  ];

  # For Hyprland UWSM enviroment settings
  xdg.configFile = {
    "uwsm/env-hyprland" = {
      source = ./HyprStuff/env-hyprland;
    };
  };
}
