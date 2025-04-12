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
    SUDO_PROMPT = lib.concatStrings [
      "$(tput setaf 1 bold)[sudo]"
      "$(tput sgr0) $(tput setaf 3)password for"
      "$(tput sgr0)"
      "$(tput setaf 5)%p"
      "$(tput sgr0): "
    ];
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
          "[](surface0)"
          "$os"
          "$username"
          "[](bg:peach fg:surface0)"
          "$directory"
          "[](fg:peach bg:green)"
          "$git_branch"
          "$git_status"
          "[](fg:green bg:teal)"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "[](fg:teal bg:blue)"
          "$docker_context"
          "$conda"
          "[](fg:blue bg:mauve)"
          "$time"
          "[ ](fg:mauve)"
          "$line_break$character"
        ];

        palette = "catppuccin_mocha";

        palettes.catppuccin_mocha = {
          rosewater = "#${myTheme.base06}";
          flamingo = "#${myTheme.base0F}";
          mauve = "#${myTheme.base0E}";
          red = "#${myTheme.base08}";
          peach = "#${myTheme.base09}";
          yellow = "#${myTheme.base0A}";
          green = "#${myTheme.base0B}";
          teal = "#${myTheme.base0C}";
          blue = "#${myTheme.base0D}";
          lavender = "#${myTheme.base07}";
          text = "#${myTheme.base05}";
          surface0 = "#${myTheme.base02}";
          surface1 = "#${myTheme.base03}";
          surface2 = "#${myTheme.base04}";
          base = "#${myTheme.base00}";
          mantle = "#${myTheme.base01}";
        };

        os = {
          disabled = false;
          style = "bg:surface0 fg:text";

          symbols = {
            Windows = "󰍲";
            Ubuntu = "󰕈";
            SUSE = "";
            Raspbian = "󰐿";
            Mint = "󰣭";
            Macos = "󰀵";
            Manjaro = "";
            Linux = "󰌽";
            Gentoo = "󰣨";
            Fedora = "󰣛";
            Alpine = "";
            Amazon = "";
            Android = "";
            Arch = "󰣇";
            Artix = "󰣇";
            EndeavourOS = "";
            CentOS = "";
            Debian = "󰣚";
            Redhat = "󱄛";
            RedHatEnterprise = "󱄛";
            Pop = "";
            NixOS = " ";
          };
        };

        username = {
          show_always = true;
          style_user = "bg:surface0 fg:text";
          style_root = "bg:surface0 fg:text";
          format = "[ $user ]($style)";
        };

        directory = {
          style = "fg:mantle bg:peach";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";

          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = "󰝚 ";
            "Pictures" = " ";
            "Developer" = "󰲋 ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:teal";
          format = "[[ $symbol $branch ](fg:base bg:teal)]($style)";
        };

        git_status = {
          style = "bg:teal";
          format = "[[($all_status$ahead_behind )](fg:base bg:teal)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:base bg:blue)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:base bg:blue)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:base bg:blue)]($style)";
        };

        java = {
          symbol = "";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:base bg:blue)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:surface0";
          format = "[[  $time ](fg:mantle bg:mauve)]($style)";
        };

        line_break = {
          disabled = false;
        };

        character = {
          disabled = false;
          success_symbol = "[](bold fg:green)";
          error_symbol = "[](bold fg:red)";
          vimcmd_symbol = "[](bold fg:green)";
          vimcmd_replace_one_symbol = "[](bold fg:mauve)";
          vimcmd_replace_symbol = "[](bold fg:mauve)";
          vimcmd_visual_symbol = "[](bold fg:yellow)";
        };
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
