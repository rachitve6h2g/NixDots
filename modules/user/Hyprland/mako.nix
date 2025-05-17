{
  pkgs,
  config,
  ...
}: let
  theme = config.colorScheme.palette;
in {
  services.mako = {
    enable = true;

    anchor = "top-right";
    # max-history = 10;
    font = "ComicShannsMono Nerd Font 11";
    layer = "top";
    markup = true;
    sort = "-time";

    icons = true;
    iconPath = "${pkgs.gruvbox-plus-icons}/share/icons/Gruvbox-Plus-Dark";

    actions = true;

    backgroundColor = "#${theme.base00}";
    textColor = "#${theme.base05}";
    borderColor = "#${theme.base0E}";
    progressColor = "over #${theme.base02}";

    borderRadius = 10;

    defaultTimeout = 5000;
    ignoreTimeout = true;
    extraConfig = ''
      on-notify=exec ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/message.oga
      on-button-middle=exec makoctl menu -n \"$id\" wofi -S dmenu -p 'Select Action: '

      [mode=do-not-disturb]
      invisible=1

      [urgency=high]
      border-color=#${theme.base09}
    '';
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
