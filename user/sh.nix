{ lib, config, ... }:
let
  myAliases = {
    update = "sudo nixos-rebuild switch";
    cleanall = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
  };

  myTheme = config.colorScheme.palette;
in
{
  # home = {
  # 	shell = {
  # 		enableZshIntegration = true;
  # 	};
  # };
  home.sessionVariables = lib.mkForce {
    EDITOR = "vim";
  };

  programs = {
    zsh = {
      enable = true;

      # Don't forget to add
      # environment.pathsToLink = [ "/share/zsh" ];
      # to configuration.nix
      enableCompletion = true;

      autosuggestion = {
        enable = true;
        strategy = [
          "completion"
        ];
        # TODO: add themes using the highlight attribute
        # of the autosuggestion field
      };

      dotDir = ".config/zsh";

      # TODO: set up the history attribute

      syntaxHighlighting = {
        enable = true;

        # TODO: set up the themes
        # Preferably catppuccin
      };

      shellAliases = myAliases;

    };

    starship = {
      enable = true;

      enableZshIntegration = true;

      # TODO: Set a catppuccin starship configuration
      settings = {
        add_newline = true;

        format = lib.concatStrings [
          "[](color_orange)"
          "$os"
          "$username"
          "[](bg:color_yellow fg:color_orange)"
          "$directory"
          "[](fg:color_yellow bg:color_aqua)"
          "$git_branch"
          "$git_status"
          "[](fg:color_aqua bg:color_blue)"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "[](fg:color_blue bg:color_bg3)"
          "$docker_context"
          "$conda"
          "[](fg:color_bg3 bg:color_bg1)"
          "$time"
          "[ ](fg:color_bg1)"
          "$line_break$character"
        ];

        palette = "catppuccin_mocha";

        palettes.catppuccin_mocha = [
          {
            color_fg0 = "#${myTheme.base05}";
            color_bg1 = "#${myTheme.base02}";
            color_bg3 = "#${myTheme.base03}";
            color_blue = "#${myTheme.base0D}";
            color_aqua = "#${myTheme.base0C}";
            color_green = "#${myTheme.base0C}";
            color_orange = "#${myTheme.base09}";
            color_purple = "#${myTheme.base0E}";
            color_red = "#${myTheme.base08}";
            color_yellow = "#${myTheme.base0A}";
          }
        ];
      };
    };

    eza = {
      enable = true;
      enableZshIntegration = true;

      git = true;
      icons = "auto";
      colors = "auto";

      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
