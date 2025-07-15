{ lib, pkgs, ... }:
{
  services = {
    swayidle = {
      enable = true;
      package = pkgs.swayidle;
      # systemdTarget = lib.mkForce null;

      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
      ];

      timeouts = [
        {
          timeout = 240;
          command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl --restore";
        }

        {
          timeout = 600;
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }

        {
          timeout = 660;
          command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors && ${pkgs.brightnessctl}/bin/brightnessctl --restore";
        }

        {
          timeout = 1500;
          command = "${pkgs.systemd}bin/systemctl suspend";
          resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors && ${pkgs.brightnessctl}/bin/brightnessctl --restore";
        }
      ];
    };
  };

  # For making it conform with UWSM
  systemd.user.services = {
    swayidle = {
      Unit = lib.mkForce {
        Description = "Sway idle and locking handler";
        Documentation = [ "man:swayidle(1)" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        Type = lib.mkForce "exec";
        Environment = lib.mkForce "";
        ExecCondition = lib.mkForce "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"niri:sway\" \"\" ";
        Restart = lib.mkForce "on-failure";
        Slice = lib.mkForce "background-graphical.slice";
      };
    };
  };
}
