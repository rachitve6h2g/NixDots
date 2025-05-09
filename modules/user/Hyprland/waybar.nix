{
  pkgs,
  lib,
  inputs,
  ...
}: let
  theme = inputs.colorScheme.palette;
in {
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 4;

        reload_style_on_change = true;

        modules-left = [
          "idle_inhibitor"
          "hyprland/workspaces"
        ];

        modules-center = ["clock"];

        modules-right = [
          "wireplumber"
          "network"
          "backlight"
          "battery"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            urgent = " ";
            active = " ";
            default = " ";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        clock = {
          interval = 1;
          format = "<span size='12pt'> </span> {:%I:%M:%S %p}";
          tooltip-format = "big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "<span size='12pt'> </span> {:%Y-%m-%d}";
        };

        backlight = {
          format = "{percent}% <span size='12pt'>{icon}</span>";
          format-icons = [" " " " " " " " " " " " " " " " " "];
        };
        battery = {
          interval = 1;
          states = {
            good = 80;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}% <span size='12pt'>{icon}</span>";
          format-full = "{capacity}% <span size='12pt'>{icon}</span>";
          format-charging = "{capacity}% <span size='12pt'> </span>";
          format-plugged = "{capacity}%  ";
          format-alt = "{time} <span size='12pt'>{icon}</span>";
          format-icons = [
            "<span foreground = '#f38ba8'> </span>"
            "<span foreground = '#f38ba8'> </span>"
            "<span foreground = '#f9e2af'> </span>"
            " "
            " "
          ];
        };

        wireplumber = {
          format = "VOL:{volume} %";
          format-muted = "MUTE";
        };

        network = {
          format-wifi = "<span color = '#a6e3a1' size='12pt'> </span> {essid}({signalStrength}%)";
          on-click = "killall nm-connection-editor || exec uwsm app -- nm-connection-editor.desktop";
          format-ethernet = "{ipaddr}/{cidr}  ";
          tooltip-format = "{essid} ({signalStrength}%)";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰤮 ";
        };
      };
    };
  };
  # For making it conform with UWSM
  systemd.user.services = lib.mkForce {
    waybar = {
      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Unit = {
        Description = "Waybar Service started thru UWSM";
        Documentation = ["man:waybar(1)"];
        After = ["graphical-session.target"];
      };

      Service = {
        Type = "exec";
        # QUESTION: does the pkgs.waybar here use the same package as the above overriden or does it create a different one
        ExecStart = "${pkgs.waybar}/bin/waybar";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
    };
  };
}
