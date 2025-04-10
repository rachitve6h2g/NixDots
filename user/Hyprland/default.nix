{ lib, config, ... }:
let
  myTheme = config.colorScheme.palette;
in
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./theme.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    sourceFirst = true;

    importantPrefixes = [
      "$"
      "bezier"
      "monitor"
      "env"
    ];

    # TODO: Start Hyprland with uwsm
    # And disable these settings accordingly
    systemd = {
      enable = lib.mkForce false;
      #variables = [ "--all" ];
    };

    settings = {
      "$mod" = "SUPER";

      monitor = [
        ",preferred,auto,1"
      ];

      env = [
        "LIBGL_ALWAYS_SOFTWARE,1"
      ];

      exec = [
        # "${pkgs.hyprpaper}/bin/hyprpaper &"
      ];

      bind =
        [
          "$mod, Q, exec, kitty"
          "$mod, C, killactive,"
          "$mod, I, exec, exec uwsm app -- org.qutebrowser.qutebrowser.desktop"
          "$mod, F, fullscreen, 0"
          "$modSHIFT, F, fullscreen, 1"

          # Move focus with MainMod + vim keys
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"

          # Toggle b/w different workspaces
          "$mod, Tab, workspace, e+1"

          # Swipe through workspaces
          "$mod, P, workspace, +1"
          "$mod, O, workspace, -1"

          # Move the window to different workspace
          "$modSHIFT, P, movetoworkspace, +1"
          "$modSHIFT, O, movetoworkspace, -1"

          # Example special workspace (scratchpad)
          "$mod, minus, togglespecialworkspace, magic"
          "$modSHIFT, minus, movetoworkspacesilent, special:magic"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        ));

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      # The decorations go here
      decoration = {
        rounding = 10;
        # Doesn't work in the stable
        #rounding_power = 4;

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
      };

      input = {
        repeat_rate = 250;
        follow_mouse = true;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.5;
          clickfinger_behavior = true;
        };
        special_fallthrough = true;
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

      general = {
        gaps_in = 5;
        gaps_out = 15;
        gaps_workspaces = 50;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = true;
        no_focus_fallback = true;
        layout = "dwindle";

        "col.active_border" = "rgba(${myTheme.base0D}ee) rgba(${myTheme.base0E}ee) 45deg";
        "col.inactive_border" = "rgba(${myTheme.base00}30)";
      };
    };
  };
}
