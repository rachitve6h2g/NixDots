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

    rm = "echo \"Don't use this, use trash\";false";
    ".." = "cd ..";
    ffetch = "${pkgs.fastfetch}/bin/fastfetch";
    oldvim = "${pkgs.vim}/bin/vim";
  };
in
{
  imports = [
    ./eza.nix
    ./fzf.nix
    ./starship.nix
    ./ripgrep.nix
    ./zoxide.nix
  ];
  # It's for unstable of 25.11
  home = {
    shell = {
      enableZshIntegration = true;
    };
  };

  home.sessionVariables = lib.mkForce {
    EDITOR = "myHomeModuleNvim";
    SUDO_PROMPT = lib.concatStrings [
      "$(tput setaf 1 bold)󰌾 "
      "$(tput sgr0)$(tput setaf 2) password"
      "$(tput sgr0)$(tput setaf 4) for"
      "$(tput sgr0)$(tput setaf 5) %p"
      "$(tput sgr0)$(tput setaf 3):"
    ];
  };

  home.packages = [ pkgs.sl ];

  programs = {
    fd = {
      enable = true;
    };
    zsh = {
      enable = true;
      profileExtra = # bash
        ''
          if uwsm check may-start && uwsm select; then
            exec systemd-cat -t uwsm_start uwsm start default
          fi
        '';

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

      plugins = [
        {
          name = "fzf-tab";
          src = (
            pkgs.fetchFromGitHub {
              owner = "Aloxaf";
              repo = "fzf-tab";
              rev = "2abe1f2f1cbcb3d3c6b879d849d683de5688111f";
              hash = "sha256-zc9Sc1WQIbJ132hw73oiS1ExvxCRHagi6vMkCLd4ZhI=";
            }
          );
        }
      ];
    };
  };
}
