{pkgs, ...}: let
  wallpaper2 = "${./../../../../wallpapers/main}";
in {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;

    # Set the path here
    settings = {
      ipc = "on";
      splash = "false";
      splash_offset = 2.0;
      preload = [
        "${wallpaper2}"
      ];
      wallpaper = [
        "eDP-1,${wallpaper2}"
      ];
    };
  };
}
