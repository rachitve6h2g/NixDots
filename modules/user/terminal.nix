{
  programs = {
    kitty = {
      enable = true;

      # TODO: Set the theme and integration of shell

      font = {
        name = "monospace";
        size = 14;
      };

      shellIntegration = {
        enableZshIntegration = true;
        enableBashIntegration = true;
      };

      themeFile = "rose-pine";

      settings = {
        # background_opacity = 0.8;
        notify_on_cmd_finish = "invisible 5.0 command notify-send --icon=kitty \"job finished with status: %s %c\"";
        enable_audio_bell = "no";
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
      };
    };
  };
  stylix.targets.kitty.enable = false;
}
