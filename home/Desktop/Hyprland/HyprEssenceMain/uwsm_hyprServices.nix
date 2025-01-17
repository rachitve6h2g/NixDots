{
  pkgs,
  lib,
  ...
}: {
  systemd.user = {
    enable = true;
    startServices = "sd-switch";
    services = {
      # For clipboard
      cliphist = lib.mkForce {
        Unit = {
          Description = "Clipboard history \"manager\" for wayland";
          Documentation = ["https://github.com/sentriz/cliphist"];
          After = ["graphical-session.target"];
        };

        Service = {
          Type = "exec";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist -max-items 10 store";
          Restart = "on-failure";
          Slice = "app-graphical.slice";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      # For cliphist-images service
      cliphist-images = lib.mkForce {
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
        Service = {
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist -max-dedupe-search 10 -max-items 10 store";
          Restart = "on-failure";
          Type = "exec";
          Slice = "app-graphical.slice";
        };

        Unit = {
          After = [ "graphical-session.target" ];
          Description = "Clipboard management daemon - images";
          Documentation = "https://github.com/sentriz/cliphist";
        };
      };

      # For Hyprpaper
      hyprpaper = lib.mkForce {
        Unit = {
          Description = "Hyprpaper wallpaper utility for Hyprland";
          Documentation = ["man:hyprpaper(1)"];
          After = ["graphical-session.target"];
        };

        Service = {
          Type = "exec";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
          Restart = "on-failure";
          Slice = "background-graphical.slice";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      # Waybar started by UWSM
      waybar = lib.mkForce {
        Unit = {
          Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
          Documentation = ["man:waybar(5)"];
          After = ["graphical-session.target"];
        };

        Service = {
          Type = "exec";
          ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
          ExecStart = "${pkgs.waybar}/bin/waybar";
          ExecReload = "${pkgs.util-linux}/bin/kill -SIGUSR2 $MAINPID";
          Restart = "on-failure";
          Slice = "app-graphical.slice";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      # for Hypridle
      hypridle.Unit.After = lib.mkForce ["graphical-session.target"];
    };
  };
}
