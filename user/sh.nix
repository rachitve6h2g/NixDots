{ lib, ... }:
let
  myAliases = {
    update = "sudo nixos-rebuild switch";
    cleanall = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
  };
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
