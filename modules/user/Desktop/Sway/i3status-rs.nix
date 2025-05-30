{
  programs = {
    i3status-rust = {
      enable = true;

      bars = {
        default = {
          blocks = [
            {
              block = "net";
              format = " $icon {$signal_strength $ssid $frequency|Wired connection} ";
              format_alt = " ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) on $device ";
              interval = 1;
            }

            {
              block = "cpu";
              info_cpu = 20;
              warning_cpu = 50;
              critical_cpu = 90;
              interval = 1;
            }

            {
              block = "temperature";
              format = " $icon $average avg, $max max ";
              format_alt = " $icon $min min, $max max, $average avg ";
              interval = 1;
              scale = "celsius";
            }

            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              alert_unit = "GB";
              interval = 20;
              warning = 20.0;
              alert = 10.0;
              format = " $icon root: $available.eng(w:2) ";
            }

            {
              block = "memory";
              interval = 1;
              format = " $icon $mem_total_used_percents.eng(w:2) ";
              format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
            }

            {

              block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
              ];
            }

            {
              block = "battery";
              driver = "upower";
              device = "DisplayDevice";
              interval = 1;
              full_format = " $icon $percentage ";
              format = " $icon $percentage {$time_remaining.dur(hms:true, min_unit:m) |}";
              full_threshold = 80;
              empty_threshold = 20;
              good = 70;
              warning = 40;
              critical = 30;
            }

            {
              block = "time";
              interval = 5;
              format = {
                full = " $icon  $timestamp.datetime(f:'%a %d/%m %I:%M%p') ";
                short = " $icon  $timestamp.datetime(f:'%I:%M%p')";
              };
            }

            {
              block = "uptime";
              interval = 3600;
            }

            { block = "backlight"; }
            { block = "scratchpad"; }
          ];
          theme = "gruvbox-dark";
          icons = "material-nf";

          settings = {
            icons_format = "{icon}";
          };
        };
      };
    };
  };
}
