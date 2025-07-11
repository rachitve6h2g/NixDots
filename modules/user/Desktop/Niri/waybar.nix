{
  config,
  lib,
  pkgs,
  ...
}:
let
  theme = config.colorScheme.palette;
in
{
  programs.waybar = {
    enable = true;

    package = (
      pkgs.waybar.override {
        evdevSupport = false;
        gpsSupport = false;
        mpdSupport = false;
        mprisSupport = false;
        niriSupport = true;
        traySupport = false;
      }
    );

    systemd = {
      enable = true;
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 4;
        reload_style_on_change = true;

        modules-left = [
          "idle_inhibitor"
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "pulseaudio/slider"
          "backlight"
          "backlight/slider"
          "network"
          "upower"
        ];

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        "niri/workspaces" = {
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

        clock = {
          interval = 1;
          format = "<span size='12pt'> </span> {:%I:%M:%S %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "<span size='12pt'> </span> {:%Y-%m-%d}";
        };

        pulseaudio = {
          format = "{volume}% <span size='12pt'>{icon}</span>";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "<span size='12pt'> </span>{format_source}";
          format-source = "{volume}% <span size='12pt'></span>";
          format-source-muted = " ";
          format-icons = {
            headphone = "";
            headset = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };

        "pulseaudio/slider" = {
          min = 1;
          max = 80;
          orientation = "horizontal";
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
          ];
        };

        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        network = {
          format-wifi = "<span color = '#${theme.base0C}' size='12pt'> </span> {essid}({signalStrength}%)";
          on-click = "killall nm-connection-editor || exec uwsm app -- nm-connection-editor.desktop";
          format-ethernet = "{ipaddr}/{cidr}  ";
          tooltip-format = "{essid} ({signalStrength}%)";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰤮 ";
        };
      };
    };

    style = # css
      ''
        * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: monospace;
          font-size: 12px;
          color: #${theme.base05};
        }

        window#waybar {
          background-color: transparent;
          /* background-color: #${theme.base00}; */
          /*border-bottom: 3px solid rgba(100, 114, 125, 0.5);*/
          color: #${theme.base05};
          transition-property: background-color;
          transition-duration: .5s;
          margin-top: 0px;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #workspaces {
          padding: 0px;
          background-color: #${theme.base02};
          margin-bottom: 5px;
          margin-top: 5px;
          /*padding-left: 10px;*/
          border-radius: 30px;
        }
          #workspaces button {
            padding: 0px;
          }

          #workspaces button.active {
            color: #${theme.base0A};
            /*box-shadow: inset 0 -3px #ffffff;*/

          }

          #workspaces button.empty {
            color: #${theme.base01};
          }

          #workspaces button.urgent {
            background-color: #${theme.base08};
          }

          #submap {
            background-color: #${theme.base0A};
            color: #${theme.base00};
            border-radius: 5px;
            margin: 8px 0px;
            padding: 0px 5px;
          }
          .modules-right {
              background: #${theme.base00};
              color: #${theme.base05};
              border-radius: 15px;
              margin-bottom: 5px;
              margin-right: 5px;
          }

          #backlight,
          #network,
          #pulseaudio {
            padding: 0 10px;
            color: #${theme.base05};
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
            background-color: #${theme.base05};
            color: #${theme.base00};
            border-radius: 20px;
            padding: 0px 5px;
            margin: 8px 10px;
          }

          #upower {
            border-radius: 5px;
            margin: 8px 0px;
            padding: 0px 5px;
          }

          #upower.charging {
            background-color: #${theme.base0B};
          }

          #upower.discharging {
            color: #${theme.base09};
          }

          #network {
            margin: 8px 0px;
          }

          #network.wifi {
            background-color: #${theme.base02};
            border-radius: 30px;
          }

          #network.disconnected {
            color: #${theme.base08};
          }


          #pulseaudio.muted {
            /*background-color: #90b1b1;*/
            color: #${theme.base08};
          }

          #idle_inhibitor {
            padding: 0 10px;
          }
          #idle_inhibitor.activated {
            color: #${theme.base08};
          }



          #pulseaudio-slider slider,
          #backlight-slider slider {
            min-width: 5px;
            min-height: 5px;
            border: none;
            box-shadow: none;
            background-color: #${theme.base03};
          }

          #pulseaudio-slider trough,
          #backlight-slider trough {
            min-height: 3px;
            min-width: 80px;
            border-radius: 5px;
            background-color: #${theme.base02};
        }

        #pulseaudio-slider highlight,
        #backlight-slider highlight {
            min-width: 10px;
            border-radius: 5px;
        }

        #pulseaudio-slider highlight {
          background-color: #${theme.base0D};
        }

        #background-color highlight {
          color: #${theme.base09};
        }
      '';
  };

  # # For making it conform with UWSM
  systemd.user.services = {
    waybar = lib.mkForce {
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
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"niri\" \"\" ";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
    };
  };
}
