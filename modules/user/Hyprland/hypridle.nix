{pkgs, ...}: {
  services = {
    hypridle = let
      lock_cmd = "pidof hyprlock || hyprlock";
      suspend_cmd = "pidof steam || systemctl suspend || loginctl suspend";
      before_sleep_cmd = "loginctl lock-session";
    in {
      enable = true;

      settings = {
        general = {
          inherit lock_cmd;
          inherit before_sleep_cmd;
        };

        listener = [
          {
            timeout = 120;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl --save set 3%";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl --restore";
          }

          {
            timeout = 180;
            on-timeout = "loginctl lock-session";
          }

          {
            timeout = 240;
            on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          }

          {
            timeout = 540;
            on-timeout = suspend_cmd;
          }
        ];
      };
    };
  };
}
