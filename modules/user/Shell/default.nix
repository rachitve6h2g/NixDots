{
  lib,
  pkgs,
  ...
}:
let
  myAliases = {
    gocon = "cd $HOME/.dotfiles";

    # Get image on the fly.
    kitcat = "${pkgs.kitty}/bin/kitten icat";

    # Jump to the git source dir.
    cdg = "cd $(git rev-parse --show-toplevel)";

    # For audio downloading
    yt-music = "yt-dlp -x -f bestaudio";

    # NixOS specific
    update = "sudo nixos-rebuild switch";
    cleanall = "sudo nix-collect-garbage -d && nix-collect-garbage -d";

    ".." = "cd ..";
    ffetch = "${pkgs.fastfetch}/bin/fastfetch";
    oldvim = "${pkgs.vim}/bin/vim";

    ec = "emacsclient -c";
  };
in
{
  imports = [
    ./eza.nix
    ./fzf.nix
    ./readline.nix
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
  ];
  # It's for unstable of 25.11
  home = {
    shell = {
      enableZshIntegration = true;
    };
  };

  home.sessionVariables = {
    # EDITOR = "myHomeModuleNvim";
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    SUDO_PROMPT = lib.concatStrings [
      "$(tput setaf 1 bold)󰌾 "
      "$(tput sgr0)$(tput setaf 2) password"
      "$(tput sgr0)$(tput setaf 4) for"
      "$(tput sgr0)$(tput setaf 5) %p"
      "$(tput sgr0)$(tput setaf 3):"
    ];

    # There is already one module for it in configuration.nix
    # programs.vivid.enable in core modules. Enable that first.
    # LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate rose-pine)";
  };

  home.packages = [ pkgs.sl ];

  programs = {
    fd = {
      enable = true;
    };
    zsh = {
      enable = true;
      defaultKeymap = "emacs";

      sessionVariables = {
        CASE_INSENSITIVE = "true";
      };

      initContent =
        let
          interactive_functions =
            lib.mkAfter
              # bash
              ''
                rm() { command rm -i "''${@}"; }
                cp() { command cp -i "''${@}"; }
                mv() { command mv -i "''${@}"; }
                trash() { command trash -i "''${@}"; }

              '';

          extract_function =
            lib.mkAfter
              # bash
              ''
               extract() {
                  if [ -f $1 ]; then
                    case $1 in
                    *.tar.bz2) tar xvjf $1 ;;
                    *.tar.gz) tar xvzf $1 ;;
                    *.bz2) bunzip2 $1 ;;
                    *.rar) unrar x $1 ;;
                    *.gz) gunzip $1 ;;
                    *.tar) tar xvf $1 ;;
                    *.tbz2) tar xvjf $1 ;;
                    *.tgz) tar xvzf $1 ;;
                    *.zip) unzip $1 ;;
                    *.Z) uncompress $1 ;;
                    *.7z) 7z x $1 ;;
                    *) echo "don't know how to extract '$1'..." ;;
                    esac
                  else
                    echo "'$1' is not a valid file!"
                  fi
                }

              '';
        in
        lib.mkMerge [
          interactive_functions
          extract_function
        ];

      # Don't forget to add
      # environment.pathsToLink = [ "/share/zsh" ];
      # to configuration.nix
      enableCompletion = true;

      autosuggestion = {
        enable = true;
        strategy = [
          "completion"
        ];
      };

      syntaxHighlighting = {
        enable = true;
      };

      dotDir = ".config/zsh";

      # TODO: set up the history attribute

      shellAliases = myAliases;

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };
  };
}
