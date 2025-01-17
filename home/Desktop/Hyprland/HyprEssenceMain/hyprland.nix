{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  hyprPlugins = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};

  wallpaper = "${./../../../wallpapers/wall.jpg}";
  theme = config.colorScheme.palette;
in {
  imports = [
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./uwsm_hyprServices.nix

    ./../HyprApps
  ];

  home = {
    packages = with pkgs; [
      brightnessctl
      wl-clipboard
    ];
  };

  # xdg Settings
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals =
        (with pkgs; [
          xdg-desktop-portal-gtk
        ])
        ++ [hyprPackages.xdg-desktop-portal-hyprland];

      # Write the portals.conf file
      config = {
        common = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
    };
  };

  # For hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprPackages.hyprland.override {
      enableXWayland = false;
      legacyRenderer = false;
      withSystemd = true;
    };

    # Plugins from hyprland
    plugins = with hyprPlugins; [
      # For amazing expo like workspace preview
      hyprexpo
      hyprbars
    ];

    # Disabling systemd for starting with UWSM see the host directory
    # desktop.nix module
    systemd.enable = false;

    # Put these at the top of the hyprland.conf file
    importantPrefixes = [
      "monitor"
      "source"
      "$"
      "name"
      "bezier"
    ];

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "uwsm app -T";
      "$menu" = "exec fuzzel --launch-prefix='uwsm app --' --log-no-syslog --log-level=warning";
      "$clipboard" = "cliphist | fuzzel --dmenu | cliphist decode | wl-copy";
      "$filemanager" = "exec uwsm app -- thunar.desktop";
      "$browser" = "exec uwsm app -- firefox.desktop";
      monitor = ["eDP-1,1920x1080@60.06,0x0,1"];

      # Autostart apps
      exec-once = [
        "${pkgs.xfce.thunar}/bin/thunar --daemon"
        "${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnectd"
      ];

      bind = [
          # Open several apps and stuff
          "$mod, Return, exec, $terminal"
          "$mod, Q, killactive,"
          "$mod, M, exec, uwsm stop"
          "$mod, E, exec, $fileManager"
          "$mod, space, togglefloating,"
          "$mod, D, exec, $menu"
          "$mod, W, pseudo,"
          "$mod, S, togglesplit,"
          "$mod, F, fullscreen, 0"
          "$mod SHIFT, F, fullscreen, 1"
          "$mod, C, exec, $clipboard"

          # Open the browsers
          "$mod, I, exec, firefox"
          "$modSHIFT, I, exec, qutebrowser"

          # Move the focus around in a window
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Move window around in a workspace
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          # For swiping a bit here and there
          "$mod, O, workspace, -1"
          "$mod, P, workspace, +1"

          # For moving windows to and fro
          "$modSHIFT, O, movetoworkspacesilent, -1"
          "$modSHIFT, P, movetoworkspacesilent, +1"

          # For toggling the special workspace
          "$mod, minus, togglespecialworkspace, magic"
          "$mod SHIFT, minus, movetoworkspacesilent, special:magic"

          # For toggling in workspace using mouse scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # For toggling the workspaces
          "$mod, Tab, workspace, e+1"
          "$modSHIFT, Tab, workspace, e-1"

          # Workspace navigation using hyprexpo
          "$mod, grave, hyprexpo:expo, toggle"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      # Mouse bindings
      bindm = [
        # For resizing using right mouse click
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Binding to work with hyprlock enabled
      bindel = [
        # multimedia keys
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 0.9"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # For brightness
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # For locked state functions
      bindl = [
        # For playerctl keys
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPlay, exec,  ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ];

      # General settings
      general = {
        gaps_in = 4;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgb(${theme.base0E}) rgb(${theme.base0D}) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Good looks matter
      decoration = {
        rounding = 20;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 14;
          passes = 4;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          range = 20;
          render_power = 4;
          offset = "0 2";
          color = "rgba(0000002A)";
        };
      };

      # Animations here
      animations = {
        enabled = true;

        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layers, 1, 2, md3_decel, slide"
          "layersIn, 1, 3, menu_decel, side"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "workspaces, 1, 2.7, softAcDecel, slide"
          "workspaces, 1, 7, menu_decel, slidefade 15%"
          "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      misc = {
        background_color = "rgba(${theme.base0E}39)";
        vfr = true;
        vrr = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;

        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;

        initial_workspace_tracking = false;

        enable_swallow = true;
        swallow_regex = [
          "^(kitty)$"
        ];
      };

      # Input settings
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        mouse_refocus = false;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
        };
      };

      # Gestures
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      windowrulev2 = [
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "bordercolor @red @maroon 45deg, fullscreen:1"
        "opacity 0.7 override 0.6 override, class:^(polkit-gnome-authentication-agent-1)$"
        "float, class:^(confirm)$"
        "float, class:^(download)$"
        "float, class:^(Picture-in-Picture)$"
        "noshadow, floating:0"
        "bordercolor rgba(ffb2bcaa) rgba(ffb2bc77),pinned:1"
      ];

      # Plugin settings go here
      plugin = {
        hyprbars = {
          bar_text_font = "Iosevka Nerd Mono";
          bar_height = 30;
          bar_padding = 10;
          bar_button_padding = 5;
          bar_precedence_over_border = true;
          bar_part_of_window = true;

          bar_color = "rgba(${theme.base00}ff)";
          "col.text" = "rgba(${theme.base05}ff)";

          hyprbars-button = [
            "rgb(${theme.base08}), 13, 󰖭 , hyprctl dispatch killactive"
            "rgb(${theme.base09}), 13, 󰖯 , hyprctl dispatch fullscreen 1"
            "rgb(${theme.base0B}), 13, 󰖰 , hyprctl dispatch movetoworkspacesilent special:magic"
          ];
        };

        # Cool hyprexpo plugin
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(000000)";
          workspace_method = "first 1";
          enable_gesture = true;
          gesture_fingers = 3;
          gesture_distance = 300;
          gesture_negative = true;
        };
      };
    };
  };

  services = {
    # For player hotkeys
    playerctld = {
      enable = true;
      package = pkgs.playerctl;
    };

    # For clipboard
    cliphist = {
      enable = true;
      allowImages = true;
    };

    # Enable desktop notifications
    mako = {
      enable = true;
      actions = true;
      anchor = "top-left";
    };
  };
}
