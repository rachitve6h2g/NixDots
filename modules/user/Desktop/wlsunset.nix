{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services = lib.mkForce {
    wlsunset = {
      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Unit = {
        Description = "Day/night gamma adjustments for Wayland";
        Documentation = ["man:wlsunset(1)"];
        After = ["graphical-session.target"];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 5000 -T 7000 -s 18:00 -S 06:30";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
    };
  };
}
