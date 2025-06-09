{
  pkgs,
  lib,
  ...
}: let
  rose-pine-room = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/fr0st-iwnl/wallz/refs/heads/main/Ros%C3%A9%20Pine/18.%20Ros%C3%A9%20Pine.jpeg";
    hash = "sha256-H4OM5VRoRQF4/L8OhJYd7BTQsxy75CYiLQvECGef3sk=";
  };
in {
  services = {
    hyprpaper = {
      enable = true;

      settings = {
        # ipc = "on";
        # spash = false;

        preload = [
          "${rose-pine-room}"
        ];

        wallpaper = [
          ",${rose-pine-room}"
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
