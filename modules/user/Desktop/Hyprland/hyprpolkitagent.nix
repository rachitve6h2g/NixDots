{ lib, pkgs, ... }:
{
  # For making it conform with UWSM
  systemd.user.services = lib.mkForce {
    hyprpolkitagent = {
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Unit = {
        Description = "Hyprland Policykit Agent";
        Documentation = [ "https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent/" ];
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
        Restart = "on-failure";
        TimeoutStopSec = "5sec";
        Slice = "session.slice";
      };
    };
  };
}
