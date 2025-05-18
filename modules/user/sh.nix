{
  lib,
  config,
  pkgs,
  ...
}:
let
  myAliases = {
    update = "sudo nixos-rebuild switch";
    cleanall = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    rm = "echo \"Don't use this, use trash\";false";
    ".." = "cd ..";
    # peaclock = "${pkgs.peaclock}/bin/peaclock --config-dir ~/.config/peaclock --config ~/.config/peaclock/config";
    btop = "btop --utf-force";
    ffetch = "${pkgs.fastfetch}/bin/fastfetch";
  };

  myTheme = config.colorScheme.palette;
in
{
  # It's for unstable of 25.05
  # home = {
  #   shell = {
  #     enableZshIntegration = true;
  #   };
  # };
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

      # TODO: Set read only file system icon somewhere
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
          time_format = "%I:%M %p";
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

  # TODO: replace colors here with nix-colors
  xdg.configFile."eza/theme.yml".text =
    # yaml
    ''
      colourful: true

      filekinds:
        normal: {foreground: "#ebdbb2"}
        directory: {foreground: "#83a598"}
        symlink: {foreground: "#8ec07c"}
        pipe: {foreground: "#928374"}
        block_device: {foreground: "#fb4934"}
        char_device: {foreground: "#fb4934"}
        socket: {foreground: "#665c54"}
        special: {foreground: "#d3869b"}
        executable: {foreground: "#b8bb26"}
        mount_point: {foreground: "#fe8019"}

      perms:
        user_read: {foreground: "#ebdbb2"}
        user_write: {foreground: "#fabd2f"}
        user_execute_file: {foreground: "#b8bb26"}
        user_execute_other: {foreground: "#b8bb26"}
        group_read: {foreground: "#ebdbb2"}
        group_write: {foreground: "#fabd2f"}
        group_execute: {foreground: "#b8bb26"}
        other_read: {foreground: "#bdae93"}
        other_write: {foreground: "#fabd2f"}
        other_execute: {foreground: "#b8bb26"}
        special_user_file: {foreground: "#d3869b"}
        special_other: {foreground: "#928374"}
        attribute: {foreground: "#bdae93"}

      size:
        major: {foreground: "#bdae93"}
        minor: {foreground: "#8ec07c"}
        number_byte: {foreground: "#ebdbb2"}
        number_kilo: {foreground: "#ebdbb2"}
        number_mega: {foreground: "#83a598"}
        number_giga: {foreground: "#d3869b"}
        number_huge: {foreground: "#d3869b"}
        unit_byte: {foreground: "#bdae93"}
        unit_kilo: {foreground: "#83a598"}
        unit_mega: {foreground: "#d3869b"}
        unit_giga: {foreground: "#d3869b"}
        unit_huge: {foreground: "#fe8019"}

      users:
        user_you: {foreground: "#ebdbb2"}
        user_root: {foreground: "#fb4934"}
        user_other: {foreground: "#d3869b"}
        group_yours: {foreground: "#ebdbb2"}
        group_other: {foreground: "#928374"}
        group_root: {foreground: "#fb4934"}

      links:
        normal: {foreground: "#8ec07c"}
        multi_link_file: {foreground: "#fe8019"}

      git:
        new: {foreground: "#b8bb26"}
        modified: {foreground: "#fabd2f"}
        deleted: {foreground: "#fb4934"}
        renamed: {foreground: "#8ec07c"}
        typechange: {foreground: "#d3869b"}
        ignored: {foreground: "#928374"}
        conflicted: {foreground: "#cc241d"}

      git_repo:
        branch_main: {foreground: "#ebdbb2"}
        branch_other: {foreground: "#d3869b"}
        git_clean: {foreground: "#b8bb26"}
        git_dirty: {foreground: "#fb4934"}

      security_context:
        colon: {foreground: "#928374"}
        user: {foreground: "#ebdbb2"}
        role: {foreground: "#d3869b"}
        typ: {foreground: "#665c54"}
        range: {foreground: "#d3869b"}

      file_type:
        image: {foreground: "#fabd2f"}
        video: {foreground: "#fb4934"}
        music: {foreground: "#b8bb26"}
        lossless: {foreground: "#8ec07c"}
        crypto: {foreground: "#928374"}
        document: {foreground: "#ebdbb2"}
        compressed: {foreground: "#d3869b"}
        temp: {foreground: "#cc241d"}
        compiled: {foreground: "#83a598"}
        build: {foreground: "#928374"}
        source: {foreground: "#83a598"}

      punctuation: {foreground: "#928374"}
      date: {foreground: "#fabd2f"}
      inode: {foreground: "#bdae93"}
      blocks: {foreground: "#a89984"}
      header: {foreground: "#ebdbb2"}
      octal: {foreground: "#8ec07c"}
      flags: {foreground: "#d3869b"}

      symlink_path: {foreground: "#8ec07c"}
      control_char: {foreground: "#83a598"}
      broken_symlink: {foreground: "#fb4934"}
      broken_path_overlay: {foreground: "#928374"}
    '';
}
