{
  pkgs,
  config,
  ...
}:
let
  theme = config.colorScheme.palette;
in
{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      # max-history = 10;
      font = "ComicShannsMono Nerd Font 11";
      layer = "top";
      markup = true;
      sort = "-time";

      icons = true;
      icon-path = "${pkgs.gruvbox-plus-icons}/share/icons/Gruvbox-Plus-Dark";

      actions = true;

      background-color = "#${theme.base00}";
      text-color = "#${theme.base05}";
      border-color = "#${theme.base0E}";
      progress-color = "over #${theme.base02}";

      border-radius = 10;

      default-timeout = 5000;
      ignore-timeout = true;
      on-notify = "exec ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/message.oga";
      on-button-middle = "exec makoctl menu -n \"$id\" wofi -S dmenu -p 'Select Action: '";

      # Sections are written like this
      "mode=do-not-disturb" = {
        invisible = 1;
      };

      "urgency=high" = {
        border-color = "#${theme.base09}";
      };
    };
  };
  # For making it conform with UWSM
  #systemd.user.services = lib.mkForce {
  #  mako = {
  #    Install = {
  #      WantedBy = ["graphical-session.target"];
  #    };

  #    Unit = {
  #      Description = "Lightweight Wayland notification daemon";
  #      Documentation = ["man:mako(1)"];
  #      After = ["graphical-session.target"];
  #    };

  #    Service = {
  #      Type = "exec";
  #      ExecStart = "${pkgs.mako}/bin/mako";
  #      ExecReload = "${pkgs.mako}/bin/makoctl reload";
  #      ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
  #      Restart = "on-failure";
  #      Slice = "background-graphical.slice";
  #    };
  #  };
  #};
}
