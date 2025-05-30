{
  pkgs,
  lib,
  config,
  ...
}:
let
  theme = config.colorScheme.palette;
  # Remember to provide the appropriate shebang when using this
  workspace_gawk =
    pkgs.pkgs.writeScript "workspace_gawk" # gawk
      ''
        #!${pkgs.gawk}/bin/gawk -f
        ${builtins.readFile ./workspace.gawk}
      '';
in
{
  imports = [ ./i3status-rs.nix ];
  home.pointerCursor.sway.enable = true;

  xdg.configFile."uwsm/env-sway".source = ./uwsm/env-sway;
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;

    systemd = lib.mkForce {
      enable = false;
    };

    wrapperFeatures = {
      base = true;
      gtk = true;
    };

    config = {
      workspaceAutoBackAndForth = true;

      colors = {
        background = "#${theme.base07}";
        focused = {
          background = "#${theme.base00}";
          border = "#${theme.base0A}";
          childBorder = "#${theme.base0D}";
          indicator = "#${theme.base0E}";
          text = "#${theme.base07}";
        };
        focusedInactive = {
          background = "#${theme.base01}";
          border = "#${theme.base00}";
          childBorder = "#${theme.base01}";
          indicator = "#${theme.base03}";
          text = "#${theme.base05}";
        };
        placeholder = {
          background = "#${theme.base00}";
          border = "#${theme.base00}";
          childBorder = "#${theme.base00}";
          indicator = "#${theme.base00}";
          text = "#${theme.base05}";
        };
        unfocused = {
          background = "#${theme.base00}";
          border = "#${theme.base00}";
          childBorder = "#${theme.base03}";
          indicator = "#${theme.base04}";
          text = "#${theme.base05}";
        };
        urgent = {
          background = "#${theme.base08}";
          border = "#${theme.base08}";
          childBorder = "#${theme.base06}";
          indicator = "#${theme.base06}";
          text = "#${theme.base00}";
        };
      };
      bars = [
        {
          colors = {
            background = "#${theme.base00}";
            statusline = "#${theme.base05}";
            focusedStatusline = "#${theme.base07}";
            focusedSeparator = "#${theme.base00}";

            focusedWorkspace = {
              border = "#${theme.base00}";
              background = "#${theme.base0E}";
              text = "#${theme.base00}";
            };
            activeWorkspace = {
              border = "#${theme.base00}";
              background = "#${theme.base04}";
              text = "#${theme.base07}";
            };
            inactiveWorkspace = {
              border = "#${theme.base00}";
              background = "#${theme.base00}";
              text = "#${theme.base07}";
            };
            urgentWorkspace = {
              border = "#${theme.base00}";
              background = "#${theme.base08}";
              text = "#${theme.base00}";
            };
          };
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/i3status-rust/config-default.toml";
          fonts = {
            names = [ "ComicShannsMono Nerd Font" ];
            style = "Regular Bold";
            size = 10.0;
          };
        }
      ];

      # Configure the background
      output = {
        "*" = {
          bg = "${./current} fill";
        };
      };

      # Seat settings
      seat = {
        "*" = {
          hide_cursor = "when-typing enable";
        };
      };

      startup = [
        {
          command = "exec uwsm finalize FINALIZED=SWAYSOCK I3SOCK XCURSOR_THEME XCURSOR_SIZE WAYLAND_DISPLAY";
        }
      ];

      # Input configuration
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };

      gaps = {
        inner = 5;
        outer = 2;
        smartGaps = false;
      };

      window = {
        border = 2;
        titlebar = false;
      };

      modifier = "Mod4";
      terminal = "exec uwsm app -T";
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      # Now come the keybindings
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          term = config.wayland.windowManager.sway.config.terminal;
          browser = "exec uwsm app -- org.qutebrowser.qutebrowser.desktop";
        in
        lib.mkOptionDefault {
          "${mod}+q" = "exec ${term}";
          "${mod}+c" = "kill";
          "${mod}+n" = "split none";
          "${mod}+u" = "sticky toggle";
          "${mod}+i" = "${browser}";

          "${mod}+tab" = "workspace next";

          "${mod}+Shift+e" =
            "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'loginctl terminate-user \"\"' ";

          "${mod}+o" =
            "swaymsg -pt get_workspaces | gawk -f ${workspace_gawk} -v move_type=\"left\"  -v num_of_workspaces=$num_of_workspaces";
          "${mod}+p" =
            "swaymsg -pt get_workspaces | gawk -f ${workspace_gawk} -v move_type=\"right\"  -v num_of_workspaces=$num_of_workspaces";
          "${mod}+Shift+o" =
            "swaymsg -pt get_workspaces | gawk -f ${workspace_gawk} -v move_type=\"container_left\"  -v num_of_workspaces=$num_of_workspaces";
          "${mod}+Shift+p" =
            "swaymsg -pt get_workspaces | gawk -f ${workspace_gawk} -v move_type=\"container_right\"  -v num_of_workspaces=$num_of_workspaces";
        };
    };
  };
}
