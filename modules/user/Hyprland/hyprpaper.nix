{
  pkgs,
  lib,
  ...
}: {
  services = {
    hyprpaper = {
      enable = true;

      settings = {
        # ipc = "on";
        # spash = false;

        preload = [
          "${./current}"
        ];

        wallpaper = [
          ",${./current}"
        ];
      };
    };
  };

  # For making it conform with UWSM
  systemd.user.services = lib.mkForce {
    hyprpaper = {
      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Unit = {
        Description = "Hyprpaper wallpaper utility for Hyprland";
        Documentation = ["man:hyprpaper(1)"];
        After = ["graphical-session.target"];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
    };
  };
}
