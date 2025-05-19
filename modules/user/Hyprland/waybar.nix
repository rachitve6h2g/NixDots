{
  pkgs,
  lib,
  config,
  ...
}:
let
  theme = config.colorScheme.palette;
in
{
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

        modules-center = [ "clock" ];

        modules-right = [
          "wireplumber"
          "network"
          "backlight"
          "upower"
          # "battery"
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
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
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
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "<span size='12pt'> </span> {:%Y-%m-%d}";
        };

        backlight = {
          format = "{percent}% <span size='12pt'>{icon}</span>";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
            " "
            " "
            " "
            " "
          ];
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

        upower = {
          icon-size = 10;
          # native-path = "/org/freedesktop/UPower/devices/battery_BAT0";
          hide-if-empty = true;
          tooltip = true;
          tooltip-spacing = 20;
          show-icon = true;
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

    style =
      # css
      ''
         *{
            font-family: ComicShannsMonoNerdFont;
            font-size: 13px;
            color: #${theme.base05};
         }

         window#waybar {
             background-color: #${theme.base00};
             transition-property: background-color;
             transition-duration: .5s;
             margin-top: 0px;
         }
          window#waybar.hidden {
              opacity: 0.2;
          }
        #workspaces button {
            padding: 0px;
          }
              #workspaces button.active {
         /*box-shadow: inset 0 -3px #ffffff;*/
          }

          #workspaces button.empty {
              color: #282828;
          }

          #workspaces button.urgent {
              background-color: #ea6962;
          }

          #mode {
              background-color: #d8a657;
              color: #141617;
              border-radius: 5px;
              margin: 8px 0px;
              padding: 0px 5px;
          }

          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #wireplumber,
          #custom-media,
          #tray,
          #scratchpad,
          #power-profiles-daemon,
          #mpd {
              padding: 0 10px;
              color: #d4be98;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 5px;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          #clock {
              background-color: #d4be98;
              color: #141617;
              border-radius: 20px;
              padding: 0px 5px;
              margin: 8px 10px;
          }

          #battery {
              /*background-color: #ffffff;*/
              /*color: #j;*/
              border-radius: 5px;
              margin: 8px 0px;
              padding: 0px 5px;
          }

          #battery.charging, #battery.plugged {
              color: #282828;
              background-color: #a9b665;
          }

          @keyframes blink {
              to {
                  /*background-color: #ffffff;*/
                  /*color: #000000;*/
              }
          }

          /* Using steps() instead of linear as a timing function to limit cpu usage */
          #battery.critical:not(.charging) {
              background-color: #ea6962;
              color: #282828;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: steps(12);
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          #power-profiles-daemon {
              padding-right: 15px;
          }

          #power-profiles-daemon.performance {
              /*background-color: #f53c3c;*/
              color: #ea6962;
          }

          #power-profiles-daemon.balanced {
              /*background-color: #2980b9;*/
              color: #d8a657;
          }

          #power-profiles-daemon.power-saver {
              /*background-color: #2ecc71;*/
              color: #a9b665;
          }

          label:focus {
              /*background-color: #000000;*/
          }

          #cpu {
              /*background-color: #2ecc71;*/
              /*color: #000000;*/
          }

          #memory {
              /*background-color: #9b59b6;*/
          }

          #disk {
              /*background-color: #964B00;*/
          }

          #backlight {
              /*background-color: #90b1b1;*/
          }

          #network {
              margin: 8px 0px;
          }

          #network.wifi {
              background-color: #32302f;
              border-radius: 30px;
          }

          #network.disconnected {
              color: #ea6962;
          }

          #pulseaudio {
              /*background-color: #f1c40f;*/
              /*color: #000000;*/
          }

          #pulseaudio.muted {
              /*background-color: #90b1b1;*/
              color: #ea6962;
          }

          #wireplumber {
              /*background-color: #fff0f5;*/
              /*color: #000000;*/
          }

          #wireplumber.muted {
              /*background-color: #f53c3c;*/
          }

          #custom-media {
              /*background-color: #66cc99;*/
              /*color: #2a5c45;*/
              min-width: 100px;
          }

          #custom-media.custom-spotify {
              /*background-color: #66cc99;*/
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
              /*background-color: #f0932b;*/
          }

          #temperature.critical {
              /*background-color: #eb4d4b;*/
          }

          #tray {
              background-color: #2980b9;
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #eb4d4b;
          }

          #idle_inhibitor {
              padding: 0 10px;
          }
          #idle_inhibitor.activated {
              color: #ea6962;
          }

          #mpd {
              /*background-color: #66cc99;*/
              color: #2a5c45;
          }

          #mpd.disconnected {
              /*background-color: #f53c3c;*/
          }

          #mpd.stopped {
              /*background-color: #90b1b1;*/
          }

          #mpd.paused {
              /*background-color: #51a37a;*/
          }

          #language {
              /*background: #00b093;*/
              color: #740864;
              padding: 0 5px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state {
              /*background: #97e1ad;*/
              /*color: #000000;*/
              padding: 0 0px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state > label {
              padding: 0 5px;
          }

          #keyboard-state > label.locked {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad.empty {
          	background-color: transparent;
          }

          #privacy {
              padding: 0;
          }

          #privacy-item {
              padding: 0 5px;
              color: white;
          }

          #privacy-item.screenshare {
              /*background-color: #cf5700;*/
          }

          #privacy-item.audio-in {
              /*background-color: #1ca000;*/
          }

          #privacy-item.audio-out {
              /*background-color: #0069d4;*/
          }

      '';
  };
  # For making it conform with UWSM
  systemd.user.services = lib.mkForce {
    waybar = {
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Unit = {
        Description = "Waybar Service started thru UWSM";
        Documentation = [ "man:waybar(1)" ];
        After = [ "graphical-session.target" ];
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
