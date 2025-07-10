{ lib, pkgs, ... }:
{
  # services = {
  #   swayidle = {
  #     enable = true;
  #     package = pkgs.swayidle;
  #     systemdTarget = lib.mkForce null;
  #
  #     events = [
  #       {
  #         event = "before-sleep";
  #         command = "${pkgs.hyprlock}/bin/hyprlock";
  #       }
  #       {
  #         event = "lock";
  #         command = "${pkgs.hyprlock}/bin/hyprlock";
  #       }
  #     ];
  #
  #     timeouts = [
  #       {
  #         timeout = 240;
  #         command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
  #         resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl --restore";
  #       }
  #
  #       {
  #         timeout = 600;
  #         command = "${pkgs.hyprlock}/bin/hyprlock";
  #       }
  #
  #       {
  #         timeout = 660;
  #         command = "${pkgs.niri}/bin/niri msg output eDP-1 off";
  #         resumeCommand = "${pkgs.niri}/bin/niri msg output eDP-1 on && ${pkgs.brightnessctl}/bin/brightnessctl --restore";
  #       }
  #
  #       {
  #         timeout = 1500;
  #         command = "${pkgs.systemd}bin/loginctl suspend";
  #         resumeCommand = "${pkgs.niri}/bin/niri msg output eDP-1 on && ${pkgs.brightnessctl}/bin/brightnessctl --restore";
  #       }
  #     ];
  #   };
  # };

  xdg.configFile."swayidle/config".source = ./swayidle_config;

  # For making it conform with UWSM
  systemd.user.services = {
    swayidle = lib.mkForce {
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Unit = {
        Description = "Sway idle and locking handler";
        Documentation = [ "man:swayidle(1)" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.swayidle}/bin/swayidle";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"niri:sway\" \"\" ";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
    };
  };
}
