{
  pkgs,
  lib,
  config,
  ...
}: let
  myTheme = config.colorScheme.palette;

  inherit (lib) mkIf;
  hasEza = config.programs.eza.enable;

  myShellAliases = {
    l = mkIf hasEza "eza";
    ll = mkIf hasEza "eza -l";
    la = "eza -al";
    ".." = "cd ..";
    svi = "sudo vim";
    config = "cd $HOME/.dotfiles/";
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
        KITTY_ENABLE_WAYLAND = 1;
      };

      syntaxHighlighting = {
        enable = true;

        highlighters = [
          "main"
          "cursor"
        ];

        styles = {
          # General
          comment = "fg=#${myTheme.base04}"; # surface2 kinda grey

          # Function/Methods
          alias = "fg=#${myTheme.base0B}"; # green
          suffix-alias = "fg=#${myTheme.base0B}"; # green
          global-alias = "fg=#${myTheme.base0B}";
          function = "fg=#${myTheme.base0B}";
          command = "fg=#${myTheme.base0B}";
          precommand = "fg=#${myTheme.base0B},italic";
          autodirectory = "fg=#${myTheme.base09},italic"; # peach
          single-hyphen-option = "fg=#${myTheme.base09}";
          double-hyphen-option = "fg=#${myTheme.base09}";
          back-quoted-argument = "fg=#${myTheme.base0E}"; # mauve

          # Keywords
          # Builtins
          builtin = "fg=#${myTheme.base0B}";
          reserved-word = "fg=#${myTheme.base0B}";
          hashed-command = "fg=#${myTheme.base0B}";

          ## Pumctuation
          commandseparator = "fg=#${myTheme.base08}"; # red
          command-substitution-delimiter = "fg=#${myTheme.base05}"; # text
          command-substitution-delimiter-unquoted = "fg=#${myTheme.base05}";
          process-substitution-delimiter = "fg=#${myTheme.base05}";
          back-quoted-argument-delimiter = "fg=#${myTheme.base08}";
          back-double-quoted-argument = "fg=#${myTheme.base08}";
          back-dollar-quoted-argument = "fg=#${myTheme.base08}";

          ## Storage
          ## Strings
          command-substitution-quoted = "fg=#${myTheme.base0A}"; # yellow
          command-substitution-delimiter-quoted = "fg=#${myTheme.base0A}";
          single-quoted-argument = "fg=#${myTheme.base0A}";
          single-quoted-argument-unclosed = "fg=#${myTheme.base08}";
          double-quoted-argument = "fg=#${myTheme.base0A}";
          double-quoted-argument-unclosed = "fg=#${myTheme.base08}";
          rc-quote = "fg=#${myTheme.base0A}";

          ## Variables
          dollar-quoted-argument = "fg=#${myTheme.base05}";
          dollar-quoted-argument-unclosed = "fg=#${myTheme.base08}";
          dollar-double-quoted-argument = "fg=#${myTheme.base05}";
          assign = "fg=#${myTheme.base05}";
          named-fd = "fg=#${myTheme.base05}";
          numeric-fd = "fg=#${myTheme.base05}";

          ## No category relevant in spec
          unknown-token = "fg=#${myTheme.base08}";
          path = "fg=#${myTheme.base0E},underline";
          path_pathseparator = "fg=#${myTheme.base08},underline";
          path_prefix = "fg=#${myTheme.base0E},underline";
          path_prefix_pathseparator = "fg=#${myTheme.base08},underline";
          globbing = "fg=#${myTheme.base05}";
          history-expansion = "fg=#${myTheme.base0E}";
          back-quoted-argument-unclosed = "fg=#${myTheme.base08}";
          redirection = "fg=#${myTheme.base05}";
          arg0 = "fg=#${myTheme.base05}";
          default = "fg=#${myTheme.base05}";
          cursor = "fg=#${myTheme.base05}";
        };
      };
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

      shellAliases = myShellAliases;
    };

    bash = {
      enable = true;
      shellAliases = myShellAliases;
    };

    starship = {
      enable = true;
      settings = {
        "\$schema" = "https://starship.rs/config-schema.json";
        add_newline = false;
        command_timeout = 500;
        continuation_prompt = "[.](base) ";
        format = "$cmd_duration$directory $git_branch\n$character";
        right_format = "";
        scan_timeout = 30;

        # Sets user-defined palettes
        # palettes must be defined after this line
        palette = "catppuccin_mocha";

        battery = {
          format = "[$symbol$percentage]($style) ";
          disabled = false;
          display = [
            {
              style = "bold red";
              threshold = 30;
            }
          ];
        };

        package.disabled = true;

        character = {
          success_symbol = "[[󰄛](mauve) ❯](blue)";
          error_symbol = "[[󰄛](red) ❯](peach)";
          vimcmd_symbol = "[󰄛 ❮](subtext1)"; # For use with zsh-vi-mode
        };

        cmd_duration = {
          min_time = 0;
          format = "[](bold fg:blue)[ $duration](bold bg:blue fg:base)[](bold fg:blue) •• ";
        };

        directory = {
          disabled = false;
          format = "[](bold fg:mauve)[$path ]($style)[](bold fg:mauve)";
          home_symbol = "  ";
          read_only = "  ";
          read_only_style = "red";
          repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
          style = "bg:mauve fg:base";
          truncate_to_repo = true;
          truncation_length = 6;
          truncation_symbol = "••/";
          use_logical_path = true;
          use_os_path_sep = true;

          substitutions = {
            "Desktop" = "  ";
            "Documents" = "  ";
            "Downloads" = "  ";
            "Music" = " 󰎈 ";
            "Pictures" = "  ";
            "Videos" = "  ";
          };
        };

        env_var = {
          SHELL = {
            format = "[$symbol($env_value )]($style)";
            style = "surface1 bold italic dimmed";
            symbol = "e:";
            disabled = true;
            variable = "SHELL";
            default = "unknown shell";
          };

          USER = {
            format = "[$symbol($env_value )]($style)";
            style = "surface0 bold italic dimmed";
            symbol = "e:";
            disabled = true;
            default = "unknown user";
          };
        };

        git_branch = {
          style = "bold mauve";
          symbol = "󰘬 ";
          truncation_length = 4;
          truncation_symbol = " ";
          format = "• [](bold fg:green)[$symbol $branch(:$remote_branch)](fg:black bg:green)[ ](bold fg:green)";
        };

        git_commit = {
          commit_hash_length = 4;
          tag_symbol = " ";
        };

        git_state = {
          format = "[\($state( $progress_current of $progress_total)\)]($style) ";
          cherry_pick = "[🍒 PICKING](bold red)";
        };

        git_status = {
          conflicted = " 🏳 ";
          ahead = " 🏎💨 ";
          behind = " 😰 ";
          diverged = " 😵 ";
          untracked = " 🤷 ‍";
          stashed = " 📦 ";
          modified = " 📝 ";
          staged = "[++\($count\)](green)";
          renamed = " ✍️ ";
          deleted = " 🗑 ";
        };

        hostname = {
          ssh_only = false;
          format = "[•$hostname](bg:green bold fg:base)[](bold fg:green )";
          trim_at = ".companyname.com";
          disabled = false;
        };

        memory_usage = {
          disabled = true;
          threshold = -1;
          symbol = " ";
          style = "bold dimmed green";
        };

        time = {
          disabled = true;
          format = "🕙[\[ $time \]]($style) ";
          time_format = "%T";
        };

        username = {
          style_user = "bold bg:green fg:base";
          style_root = "red bold";
          format = "[](bold fg:cyan)[$user]($style)";
          disabled = false;
          show_always = true;
        };

        palettes = {
          catppuccin_mocha = {
            rosewater = "#f5e0dc";
            flamingo = "#f2cdcd";
            pink = "#f5c2e7";
            mauve = "#cba6f7";
            red = "#f38ba8";
            maroon = "#eba0ac";
            peach = "#fab387";
            yellow = "#f9e2af";
            green = "#a6e3a1";
            teal = "#94e2d5";
            sky = "#89dceb";
            sapphire = "#74c7ec";
            blue = "#89b4fa";
            lavender = "#b4befe";
            text = "#cdd6f4";
            subtext1 = "#bac2de";
            subtext0 = "#a6adc8";
            overlay2 = "#9399b2";
            overlay1 = "#7f849c";
            overlay0 = "#6c7086";
            surface2 = "#585b70";
            surface1 = "#45475a";
            surface0 = "#313244";
            base = "#1e1e2e";
            mantle = "#181825";
            crust = "#11111b";
          };
        };
      };
    };
    # Eza for terminal icons
    eza = {
      enable = true;
      git = true;
      icons = "auto";
      colors = "auto";
      enableZshIntegration = true;
    };
  };

  # Eza theme config file:
  xdg.configFile."eza/theme.yml".source = ./eza_catppuccin.yml;
}
