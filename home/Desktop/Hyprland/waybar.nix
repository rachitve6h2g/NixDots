{
  pkgs,
  lib,
  ...
}: {
  programs = {
    waybar = {
      enable = true;

      settings = {
        mainBar = {
          height = 36;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
          ];

          modules-center = [
            "hyprland/window"
          ];

          modules-right = [
            "idle_inhibitor"
            "wireplumber"
            "network"
            "cpu"
            "memory"
            "temperature"
            "backlight"
            "keyboard-state"
            "battery"
            "clock"
            "tray"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            warp-on-scroll = false;
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              "1" = "󰲠 ";
              "2" = "󰲢 ";
              "3" = "󰲤 ";
              "4" = "󰲦 ";
              "5" = "󰲨 ";
              urgent = "";
              focused = "";
              default = "";
            };
          };

          # Idle_inhibitor
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };
          keyboard-state = {
            numlock = true;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };
          "hyprland/submap" = {
            format = "<span style=\"italic\">{}</span>";
          };
          tray = {
            icon-size = 21;
            spacing = 10;
          };
          clock = {
            #"timezone" =  "America/New_York";
            tooltip-format = "<big>{ = %Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{%Y-%m-%d}";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{}% ";
          };
          temperature = {
            #"thermal-zone" =  2;
            #"hwmon-path" =  "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 80;
            #"format-critical" =  "{temperatureC}°C {icon}";
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
          };
          backlight = {
            #"device" =  "acpi_video1";
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };
          battery = {
            states = {
              "good" = 95;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-good = ""; #An empty format will hide the module
            format-icons = [" " " " " " " " " "];
          };
          network = {
            #"interface" =  "wlp2*", #(Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname} =  {ipaddr}/{cidr}";
          };
          wireplumber = {
          };
        };
      };

      # Set the style options here
      style =
        lib.mkForce
        /*
        css
        */
        ''
                    * {
                        font-family: 'Iosevka Nerd Font Propo';
                        font-size: 12pt;
                    }
                    window#waybar {
              background-color: rgba(43, 48, 59, 0.5);
              border-bottom: 3px solid rgba(100, 114, 125, 0.5);
              color: #ffffff;
              transition-property: background-color;
              transition-duration: .5s;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          /*
          window#waybar.empty {
              background-color: transparent;
          }
          window#waybar.solo {
              background-color: #FFFFFF;
          }
          */

          window#waybar.termite {
              background-color: #3F3F3F;
          }

          window#waybar.chromium {
              background-color: #000000;
              border: none;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              box-shadow: inset 0 -3px transparent;
              /* Avoid rounded borders under each button name */
              border: none;
              border-radius: 0;
          }

          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
              background: inherit;
              box-shadow: inset 0 -3px #ffffff;
          }

          /* you can set a style on hover for any module like this */
          #pulseaudio:hover {
              background-color: #a37800;
          }

          #workspaces button {
              padding: 0 5px;
              background-color: transparent;
              color: #ffffff;
          }

          #workspaces button:hover {
              background: rgba(0, 0, 0, 0.2);
          }

          #workspaces button.focused {
              background-color: #64727D;
              box-shadow: inset 0 -3px #ffffff;
          }

          #workspaces button.urgent {
              background-color: #eb4d4b;
          }

          #mode {
              background-color: #64727D;
              box-shadow: inset 0 -3px #ffffff;
          }

          #clock,
          #battery,
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
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #power-profiles-daemon,
          #mpd {
              padding: 0 10px;
              color: #ffffff;
          }

          #window,
          #workspaces {
              margin: 0 4px;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          #clock {
              background-color: #64727D;
          }

          #battery {
              background-color: #ffffff;
              color: #000000;
          }

          #battery.charging, #battery.plugged {
              color: #ffffff;
              background-color: #26A65B;
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          /* Using steps() instead of linear as a timing function to limit cpu usage */
          #battery.critical:not(.charging) {
              background-color: #f53c3c;
              color: #ffffff;
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
              background-color: #f53c3c;
              color: #ffffff;
          }

          #power-profiles-daemon.balanced {
              background-color: #2980b9;
              color: #ffffff;
          }

          #power-profiles-daemon.power-saver {
              background-color: #2ecc71;
              color: #000000;
          }

          label:focus {
              background-color: #000000;
          }

          #cpu {
              background-color: #2ecc71;
              color: #000000;
          }

          #memory {
              background-color: #9b59b6;
          }

          #disk {
              background-color: #964B00;
          }

          #backlight {
              background-color: #90b1b1;
          }

          #network {
              background-color: #2980b9;
          }

          #network.disconnected {
              background-color: #f53c3c;
          }

          #pulseaudio {
              background-color: #f1c40f;
              color: #000000;
          }

          #pulseaudio.muted {
              background-color: #90b1b1;
              color: #2a5c45;
          }

          #wireplumber {
              background-color: #fff0f5;
              color: #000000;
          }

          #wireplumber.muted {
              background-color: #f53c3c;
          }

          #custom-media {
              background-color: #66cc99;
              color: #2a5c45;
              min-width: 100px;
          }

          #custom-media.custom-spotify {
              background-color: #66cc99;
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
              background-color: #f0932b;
          }

          #temperature.critical {
              background-color: #eb4d4b;
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
              background-color: #2d3436;
          }

          #idle_inhibitor.activated {
              background-color: #ecf0f1;
              color: #2d3436;
          }

          #mpd {
              background-color: #66cc99;
              color: #2a5c45;
          }

          #mpd.disconnected {
              background-color: #f53c3c;
          }

          #mpd.stopped {
              background-color: #90b1b1;
          }

          #mpd.paused {
              background-color: #51a37a;
          }

          #language {
              background: #00b093;
              color: #740864;
              padding: 0 5px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state {
              background: #97e1ad;
              color: #000000;
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
        '';
    };
  };
}
