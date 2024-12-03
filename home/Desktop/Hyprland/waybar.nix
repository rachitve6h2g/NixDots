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
        '';
    };
  };
}
