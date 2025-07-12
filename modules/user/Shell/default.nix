{
  lib,
  pkgs,
  config,
  ...
}:
let
  theme = config.colorScheme.palette;
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
    GTK_THEME = lib.mkForce "${config.gtk.theme.name}";
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
        # TODO: add themes using the highlight attribute
        # of the autosuggestion field
      };

      dotDir = ".config/zsh";

      # TODO: set up the history attribute

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

        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];
    };
  };

  xdg.configFile."fsh/custom.ini".text =
    # ini
    ''
      [base]
      default          = #${theme.base05}
      unknown-token    = #${theme.base08},bold
      commandseparator = #${theme.base0C}
      redirection      = #${theme.base0C}
      here-string-tri  = #bac2de
      here-string-text = #bac2de
      here-string-var  = #bac2de
      exec-descriptor  = none
      comment          = #6c7086
      correct-subtle   = #${theme.base07}
      incorrect-subtle = #eba0ac
      subtle-separator = none
      subtle-bg        = none
      secondary        =
      recursive-base   = #${theme.base05}

      [command-point]
      reserved-word     = #${theme.base0E}
      subcommand        = #74c7ec
      alias             = #${theme.base0D}
      suffix-alias      = #${theme.base0D}
      global-alias      = #${theme.base0D}
      builtin           = #${theme.base0E}
      function          = #${theme.base0D}
      command           = #${theme.base0D}
      precommand        = #${theme.base0E}
      hashed-command    = #${theme.base0D}
      single-sq-bracket = #${theme.base0A}
      double-sq-bracket = #${theme.base0A}
      double-paren      = #${theme.base0B}

      [paths]
      path          = #${theme.base06}
      pathseparator = #${theme.base06}
      path-to-dir   = #${theme.base06}
      globbing      = #f5c2e7
      globbing-ext  = none

      [brackets]
      paired-bracket  = bold
      bracket-level-1 = #${theme.base08}
      bracket-level-2 = #${theme.base0A}
      bracket-level-3 = #74c7ec

      [arguments]
      single-hyphen-option   = #${theme.base0C}
      double-hyphen-option   = #${theme.base0C}
      back-quoted-argument   = #${theme.base0C}
      single-quoted-argument = #${theme.base0B}
      double-quoted-argument = #${theme.base0B}
      dollar-quoted-argument = #${theme.base0B}
      optarg-string          = #${theme.base0B}
      optarg-number          = #${theme.base09}

      [in-string]
      back-dollar-quoted-argument           = #${theme.base09}
      back-or-dollar-double-quoted-argument = #${theme.base09}

      [other]
      variable             = #${theme.base09}
      assign               = none
      assign-array-bracket = none
      history-expansion    = none

      [math]
      mathvar = #f5c2e7
      mathnum = #${theme.base09}
      matherr = #${theme.base08},bold

      [for-loop]
      forvar  = #${theme.base05}
      fornum  = #${theme.base09}
      foroper = #${theme.base0D}
      forsep  = #${theme.base0D}

      [case]
      case-input       = #${theme.base09}
      case-parentheses = #9399b2
      case-condition   = #${theme.base0E}
    '';
}
