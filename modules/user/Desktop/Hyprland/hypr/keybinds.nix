{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      bind = let
        menu = "killall wofi || exec uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)";
        clipboard = "killall wofi || exec cliphist list | wofi -S dmenu | cliphist decode | wl-copy";
        wofi-power-menu = "${pkgs.wofi-power-menu}/bin/wofi-power-menu";
      in
        [
          "$mod, Return, exec, exec uwsm app -T"
          "$mod, Q, killactive,"
          "$mod, M, exec, exec loginctl terminate-user \"\""
          "$mod, S, togglesplit,"
          "$mod, I, exec, exec uwsm app -- org.qutebrowser.qutebrowser.desktop"
          "$mod, F, fullscreen, 0"
          "$modSHIFT, F, fullscreen, 1"

          "$mod, D, exec, ${menu}"
          "$mod, C, exec, ${clipboard}"
          "$mod, X, exec, ${wofi-power-menu}"

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

          # For toggling float
          "$modSHIFT, Space, togglefloating,"

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
        ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
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
}
