{ lib, pkgs, ... }: let 
  wallpaper = "%h/Pictures/Wallpapers/Courtside-Sunset.png";
in {
  # For making it conform with UWSM
  systemd.user.services = {
    wallpaper = lib.mkForce {
      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Unit = {
        Description = "Simple Wallpaper application for wayland compositors.";
        Documentation = ["man:wbg(1)"];
        After = ["graphical-session.target"];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.wbg}/bin/wbg ${wallpaper}";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"niri:sway\" \"\" ";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
    };
  };
}
