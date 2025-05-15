{
  lib,
  config,
  pkgs,
  ...
}: let
  myTheme = config.colorScheme.palette;
in {
  imports = [
    ./clipboard.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./mako.nix
    ./theme.nix
    ./waybar.nix
    ./wlsunset.nix
    ./wofi.nix
  ];

  # For uwsm login from tty
  xdg.configFile."zsh/.zprofile".text =
    # bash
    ''
      if uwsm check may-start; then
        exec uwsm start -S -F Hyprland
      fi
    '';

  wayland.windowManager.hyprland = {
    enable = true;
    sourceFirst = true;

    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];

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

      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(141617)";
          workspace_method = "center current";
          enable_gesture = true;
          gesture_distance = 300;
          gesture_positive = false;
        };
      };

      env = [
        "LIBGL_ALWAYS_SOFTWARE,1"
      ];

      exec-once = [
        "hyprpm reload -n"
      ];

      bind = let
        menu = "killall ${pkgs.wofi}/bin/wofi || exec uwsm app -- $(${pkgs.wofi}/bin/wofi --show drun --define=drun-print_desktop_file=true)";
        clipboard = "killall killall ${pkgs.wofi}/bin/wofi || exec cliphist list | ${pkgs.wofi}/bin/wofi -S dmenu | cliphist decode | wl-copy";
      in
        [
          "$mod, Q, exec, kitty"
          "$mod, C, killactive,"
          "$mod, M, exec, exec loginctl terminate-user \"\""
          "$mod, S, togglesplit,"
          "$mod, I, exec, exec uwsm app -- org.qutebrowser.qutebrowser.desktop"
          "$mod, F, fullscreen, 0"
          "$modSHIFT, F, fullscreen, 1"

          "$mod, D, exec, ${menu}"
          "$mod, V, exec, ${clipboard}"

          # Move focus with MainMod + vim keys
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"

          # Move windows around in a workspace
          "$modSHIFT, H, movewindow, l"
          "$modSHIFT, L, movewindow, r"
          "$modSHIFT, K, movewindow, u"
          "$modSHIFT, J, movewindow, d"

          # Toggle b/w different workspaces
          "$mod, Tab, workspace, e+1"

          # Swipe through workspaces
          "$mod, P, workspace, +1"
          "$mod, O, workspace, -1"

          # Move the window to different workspace
          "$modSHIFT, P, movetoworkspacesilent, +1"
          "$modSHIFT, O, movetoworkspacesilent, -1"

          # Example special workspace (scratchpad)
          "$mod, minus, togglespecialworkspace, magic"
          "$modSHIFT, minus, movetoworkspacesilent, special:magic"

          # For plugins
          "$mod, grave, hyprexpo:expo, toggle" # can be: toggle, off/disable or on/enable
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
            ]
          )
          9
        ));

      bindl = [
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl  play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%+"
        ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl 5%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
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

      dwindle = {
        pseudotile = true;
        preserve_split = true;
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

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 700;
        workspace_swipe_fingers = 3;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_direction_lock = true;
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_create_new = true;
      };

      layerrule = [
        "blur, waybar"
      ];
    };

    extraConfig =
      # hyprls
      ''
        # Submap
        # will switch to a submap called resize
        bind = $mod, R, submap, resize

        # will start a submap called "resize"
        submap = resize

        # sets repeatable binds for resizing the active window
        binde = , l, resizeactive, 10 0
        binde = , h, resizeactive, -10 0
        binde = , k, resizeactive, 0 -10
        binde = , j, resizeactive, 0 10

        # use reset to go back to the global submap
        bind = , return, submap, reset
        bind = , escape, submap, reset

        # will reset the submap, which will return to the global submap
        submap = reset
      '';
  };

  # Enable the playerctl daemon
  # systemd.user.services = lib.mkForce {
  #   playerctld = {
  #     Install = {
  #       WantedBy = ["graphical-session.target"];
  #     };

  #     Unit = {
  #       Description = "Keep track of media player activity";
  #     };

  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "${pkgs.playerctl}/bin/playerctld daemon";
  #     };
  #   };
  # };
}
