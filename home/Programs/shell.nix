{pkgs, ...}: let
  myShellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    svi = "sudo vim";
    syscon = "cd /etc/nixos/";
    cleanall = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
    update = "sudo nixos-rebuild switch";
    ffetch = "${pkgs.fastfetch}/bin/fastfetch";
  };

  # Session variables 
  sessionVars = {
    SUDO_PROMPT = "$(tput setaf 1 bold)[sudo]$(tput sgr0) $(tput setaf 3)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0):";
  };
in {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;

      localVariables = {
        SUDO_PROMPT = "$(tput setaf 1 bold)[sudo]$(tput sgr0) $(tput setaf 3)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0):";
      };

      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        strategy = ["completion"];
      };

      # Set the sessionVariables here 
      sessionVariables = sessionVars;
      cdpath = [
        "/etc/nixos/"
        "/home/chris"
      ];
      history.size = 100;
      dotDir = ".config/zsh";
      dirHashes = {
        docs = "$HOME/Documents";
        vids = "$HOME/Videos";
        dl = "$HOME/Downloads";
        pics = "$HOME/Pictures";
      };

      oh-my-zsh = {
        enable = true;
        theme = "random";
        plugins = [
          "git"
          "emotty"
          "emoji"
          "sudo"
          "colored-man-pages"
          "colorize"
        ];
      };

      shellAliases = myShellAliases;
    };

    bash = {
      enable = true;
      shellAliases = myShellAliases;
    };
  };
}
