{ pkgs, ... }:
{
  programs = {
    kitty = {
      enable = true;

      # TODO: Set the theme and integration of shell

      font = {
        package = pkgs.nerd-fonts.comic-shanns-mono;
        name = "ComicShannsMono Nerd Font";
        size = 13;
      };

      shellIntegration = {
        enableZshIntegration = true;
        enableBashIntegration = true;
      };

      themeFile = "GruvboxMaterialDarkHard";

      settings = {
        # background_opacity = 0.8;
        notify_on_cmd_finish = "invisible 5.0 command notify-send --icon=kitty \"job finished with status: %s %c\"";
        enable_audio_bell = "no";
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
      };
    };
  };
}
