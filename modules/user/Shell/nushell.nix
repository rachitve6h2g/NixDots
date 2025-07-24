{ lib, pkgs, ... }:
{

  home.shell.enableNushellIntegration = true;

  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        vi = "hx";
        vim = "hx";
        nvim = "hx";

        btop = "btop --force-utf";

        ec = "emacsclient -c";
      };

      extraConfig =
        #nu
        ''
            # For nh
            $env.NH_FLAKE = "/home/krish/.nixdots"
            
            # Common ls aliases and sort them by type and then name
            # Inspired by https://github.com/nushell/nushell/issues/7190
            def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
            def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
            def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
            def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }

            # carapce completions https://www.nushell.sh/cookbook/external_completers.html#carapace-completer
            # + fix https://www.nushell.sh/cookbook/external_completers.html#err-unknown-shorthand-flag-using-carapace
            # enable the package and integration bellow
            let carapace_completer = {|spans: list<string>|
            carapace $spans.0 nushell ...$spans
                | from json
                | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
            }
              # some completions are only available through a bridge
              # eg. tailscale
              # https://carapace-sh.github.io/carapace-bin/setup.html#nushell
              $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

              # fish completions https://www.nushell.sh/cookbook/external_completers.html#fish-completer
          let fish_completer = {|spans|
            ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
            | $"value(char tab)description(char newline)" + $in
            | from tsv --flexible --no-infer
          }

          # zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
          let zoxide_completer = {|spans|
              $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
          }

          # multiple completions
          # the default will be carapace, but you can also switch to fish
          # https://www.nushell.sh/cookbook/external_completers.html#alias-completions
          let multiple_completers = {|spans|
            ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
            let expanded_alias = scope aliases
            | where name == $spans.0
            | get -i 0.expansion

            let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
              $spans
            }
            ## alias fixer end

            match $spans.0 {
              __zoxide_z | __zoxide_zi => $zoxide_completer
              _ => $carapace_completer
            } | do $in $spans
          }

          $env.config = {
            show_banner: false,
            completions: {
              case_sensitive: false # case-sensitive completions
              quick: true           # set to false to prevent auto-selecting completions
              partial: true         # set to false to prevent partial filling of the prompt
              algorithm: "fuzzy"    # prefix or fuzzy
              external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                enable: true 
                # set to lower can improve completion performance at the cost of omitting some options
                max_results: 100 
                completer: $multiple_completers
              }
            }
          } 
          $env.PATH = ($env.PATH | 
            split row (char esep) |
            prepend /home/krish/.local/bin |
            append /usr/bin/env
          )

              # For kitty shell integration
              # see https://www.nushell.sh/blog/2024-05-28-nushell_0_94_0.html#shell-integration-config-toc
              $env.config.shell_integration = {
                osc2: true
                osc7: true
                osc8: true
                osc9_9: false
                osc133: true
                osc633: true
                reset_application_mode: true
              }
        '';
    };

    # These have to be enabled
    yazi.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    carapace.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
  };
}
