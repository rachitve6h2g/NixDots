# Anything color related is handeled
# by stylix hm.nix
{
  pkgs,
  inputs,
  lib,
  ...
}: let
  hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  wallpaper = "${./../../../wallpapers/wall.jpg}";
  wallpaper2 = "${./../../../wallpapers/totoro.jpg}";
in {
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
      extraPortals =
        (with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ])
        ++ [hyprPackages.xdg-desktop-portal-hyprland];

      # Write the portals.conf file
      config = {
        common = {
          default = [
            "hyprland"
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
      monitor = "eDP-1,1920x1080@60.06,0x0,1";

      # Autostart apps
      exec-once = [
        "${pkgs.xfce.thunar}/bin/thunar --daemon"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnectd"
      ];

      bind =
        [
          # Open several apps and stuff
          "$mod, Return, exec, $terminal"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, E, exec, $fileManager"
          "$mod, space, togglefloating,"
          "$mod, D, exec, $menu"
          "$mod, W, pseudo,"
          "$mod, S, togglesplit,"
          "$mod, F, fullscreen, 0"
          "$mod SHIFT, F, fullscreen, 1"
          "$mod, V, exec, $clipboard"

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
          "$mod, O, workspace, e-1"
          "$mod, p, workspace, e+1"

          # For moving windows to and fro
          "$mod SHIFT, O, movetoworkspacesilent, e-1"
          "$modSHIFT, P, movetoworkspacesilent, e+1"

          # For toggling the special workspace
          "$mod, minus, togglespecialworkspace, magic"
          "$mod SHIFT, minus, movetoworkspacesilent, special:magic"

          # For toggling in workspace using mouse scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # For tofi launcher
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
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # General settings
      general = {
        gaps_in = 10;
        gaps_out = 30;
        border_size = 2;
        # "col.active_border" =
        # "col.inactive_border =
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Good looks matter
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = true;
          range = 30;
          render_power = 3;
          scale = 0.9;
          offset = "25 40";
        };
      };

      # Animations here
      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
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
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        enable_swallow = true;
        swallow_regex = [
          "^(kitty)$"
        ];
      };

      # Input settings
      input = {
        kb_layout = "us";
        follow_mouse = true;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
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
      ];
    };
  };

  # Enabling hyprland features
  programs = {
    hyprlock = {
      enable = true;
      package = pkgs.hyprlock;

      # get these prefixes first
      importantPrefixes = [
        "$"
        "monitor"
        "size"
        "source"
      ];

      # Settings for hyprlock
      settings = {
        background = {
          monitor = " ";
          path = lib.mkForce "${wallpaper}";
          blur_passes = 1;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        # I am in love with the shape of you (talking about the password prompt)
        shape = {
          monitor = " ";
          size = "360, 60";
          # color = "rgba(17, 17, 17, 1.0)";
          rounding = -1;
          border_size = 8;
          # border_color = "rgba(0, 207, 230, 1.0)";
          rotate = 0;
          xray = false;
          position = "0, 80";
          halign = "center";
          valign = "center";
        };

        # the input field goes here
        # input-field = [
        #   {
        #     monitor = " ";
        #     size = "200, 50";
        #     outline_thickness = 3;
        #     # outer_color = "rgb(151515)";
        #     # inner_color = "rgb(200, 200, 200)";
        #     # font_color = "rgb(10, 10, 10)";
        #     hide_input = false;
        #     rounding = -1;# -1 means complete rounding (circle/oval)
        #     # check_color = "rgb(204, 136, 34)";
        #     # fail_color = "rgb(204, 34, 34)";# if authentication failed, changes outer_color and fail message color
        #     fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";# can be set to empty
        #     fail_timeout = 2000;# milliseconds before fail_text and fail_color disappears
        #     fail_transition = 300;# transition time in ms between normal outer_color and fail_color
        #     numlock_color = -1;
        #     invert_numlock = false;# change color if numlock is off
        #     swap_font_color = false; # see below
        #     position = "0, -20";
        #     halign = "center";
        #     valign = "center";
        #   }
        # ];

        label = [
          {
            monitor = " ";
            text = "Hi there, $USER";
            text_align = "center";
            # color = "rgba(200, 200, 200, 1.0)";
            font_size = 25;
            rotate = 0;
            position = "0, 80";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };

  # some services necessary for hyprland
  services = {
    # The wallpaper service
    hyprpaper = {
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

    # The idle service
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }

          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }

          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }

          {
            timeout = 1800;
            on-timeout = "loginctl suspend";
          }
        ];
      };
    };

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

  # Enable hyprland user services
  systemd.user = {
    enable = true;
    startServices = "sd-switch";
  };
}
