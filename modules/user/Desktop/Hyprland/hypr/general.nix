{config, ...}: let
  theme = config.colorScheme.palette;
in {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ",preferred,auto,1"
    ];

    general = {
      gaps_in = 2;
      gaps_out = 4;
      gaps_workspaces = 50;
      border_size = 2;
      resize_on_border = false;
      allow_tearing = true;
      no_focus_fallback = true;
      layout = "dwindle";
    };

    # The decorations go here
    decoration = {
      rounding = 10;
      # Doesn't work in the stable
      rounding_power = 4;

      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = true;
        ignore_window = true;
        range = 20;
        offset = "0 2";
        render_power = 4;
        color = "rgba(${theme.base00}ee)";
      };

      blur = {
        enabled = true;
        xray = true;
        special = true;
        new_optimizations = true;
        size = 14;
        passes = 4;
        brightness = 1;
        noise = 0.01;
        contrast = 1;
        popups = true;
        popups_ignorealpha = 0.6;
      };
      dim_special = 0.2;
      dim_inactive = false;
      dim_strength = 0.2;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    misc = {
      vfr = 1;
      vrr = 1;
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
      enable_swallow = true;
      swallow_regex = "^(kitty)$";

      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      new_window_takes_over_fullscreen = 2;
      allow_session_lock_restore = true;
    };
  };
}
