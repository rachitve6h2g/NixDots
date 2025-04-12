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
      settings = {
        add_newline = true;

        format = lib.concatStrings [
          "[](peach)"
          "$os"
          "$username"
          "[](bg:yellow fg:peach)"
          "$directory"
          "[](fg:yellow bg:teal)"
          "$git_branch"
          "$git_status"
          "[](fg:teal bg:blue)"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "[](fg:blue bg:surface1)"
          "$docker_context"
          "$conda"
          "[](fg:surface1 bg:surface0)"
          "$time"
          "[ ](fg:surface0)"
          "$line_break$character"
        ];

        palette = "catppuccin_mocha";

        palettes.catppuccin_mocha = {
          rosewater = "#f4dbd6";
          flamingo = "#f0c6c6";
          pink = "#f5bde6";
          mauve = "#c6a0f6";
          red = "#ed8796";
          maroon = "#ee99a0";
          peach = "#f5a97f";
          yellow = "#eed49f";
          green = "#a6da95";
          teal = "#8bd5ca";
          sky = "#91d7d3";
          sapphire = "#7dc4e4";
          blue = "#8aadf4";
          lavender = "#b7bdf8";
          text = "#cad3f5";
          subtext1 = "#b8c0e0";
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
          overlay1 = "#8087a2";
          overlay0 = "#6e738d";
          surface0 = "#363a4f";
          surface1 = "#494d64";
          surface2 = "#5b6078";
          base = "#24273a";
          mantle = "#1e2030";
          crust = "#181926";
        };

        os = {
          disabled = false;
          style = "bg:peach fg:text";

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
          };
        };

        username = {
          show_always = true;
          style_user = "bg:peach fg:text";
          style_root = "bg:peach fg:text";
          format = "[ $user ]($style)";
        };

        directory = {
          style = "fg:text bg:yellow";
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
          format = "[[ $symbol $branch ](fg:text bg:teal)]($style)";
        };

        git_status = {
          style = "bg:teal";
          format = "[[($all_status$ahead_behind )](fg:text bg:teal)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:text bg:blue)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:text bg:blue)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:text bg:blue)]($style)";
        };

        java = {
          symbol = "";
          style = "bg:blue";
          format = "[[ $symbol( $version) ](fg:text bg:blue)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:surface0";
          format = "[[  $time ](fg:text bg:surface0)]($style)";
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
