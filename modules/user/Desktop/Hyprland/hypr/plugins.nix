{
  pkgs,
  inputs,
  config,
  ...
}: let
  theme = config.colorScheme.palette;

  # Remove this once the error is fixed
  # Keep track of it https://github.com/hyprwm/hyprland-plugins/pull/338/files
  hyprtrails = pkgs.hyprlandPlugins.hyprtrails.overrideAttrs (
    _: _: {
      src = "${inputs.hyprlandPlugins}/hyprtrails";
    }
  );
in {
  wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
      hyprtrails
      hypr-dynamic-cursors
    ];
    settings = {
      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(${theme.base00})";
          workspace_method = "center current";
          enable_gesture = true;
          gesture_fingers = 3;
          gesture_distance = 300;
          gesture_positive = false;
        };

        hyprtrails.color = "rgba(${theme.base0E}cc)";

        dynamic-cursors = {
          enabled = true;
          mode = "none";

          threshold = 2;

          shake = {
            enabled = true;
            nearest = true;
            threshold = 6.0;
            base = 4.0;
            speed = 4.0;
            influence = 0.0;
            limit = 0.0;
            timeout = 2000;
            effects = false;
            ipc = false;
          };
          hyprcursor = {
            nearest = true;
            enabled = true;
            resolution = -1;
            fallback = "clientside";
          };
        };
      };
    };
  };
}
