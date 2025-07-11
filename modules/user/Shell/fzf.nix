{ config, ... }:
let
  theme = config.colorScheme.palette;
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    fileWidgetCommand = ''fd --type file --type directory --hidden --exclude .git'';

    changeDirWidgetCommand = "fd --type directory --hidden --exclude .git";

    # Default command that is executed for fzf - $FZF_DEFAULT_COMMAND
    defaultCommand = "fd --type file --hidden --exclude .git";

    colors = {
      "bg+" = "#${theme.base02}";
      bg = "#${theme.base00}";
      spinner = "#${theme.base09}";
      hl = "#${theme.base0A}";
      fg = "#${theme.base04}";
      header = "#${theme.base0B}";
      gutter = "#${theme.base00}";
      info = "#${theme.base0C}";
      pointer = "#${theme.base0D}";
      marker = "#${theme.base08}";
      "fg+" = "#${theme.base05}";
      prompt = "#${theme.base04}";
      "hl+" = "#${theme.base0A}";
      border = "#403d52"; # Rose-pine color
    };
  };
}
