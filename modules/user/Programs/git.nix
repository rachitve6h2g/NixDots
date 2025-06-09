{
  pkgs,
  config,
  lib,
  ...
}:
let
  theme = config.colorScheme.palette;
in
{
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile ./ssh/id_ed25519.pub}";

  programs = {
    git = {
      enable = true;

      userName = "Rachit Kumar Verma";
      userEmail = "rachitverma1122@gmail.com";

      aliases = {
        co = "checkout";
        s = "status";
        ss = "status --short --branch";
      };

      extraConfig = {
        credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";

        push = {
          autoSetupRemote = true;
        };

        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        };
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };

    gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
      };
    };

    ssh = {
      enable = true;
      hashKnownHosts = true;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };

    lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
          theme = {
            activeBorderColor = [
              "#${theme.base0A}"
              "bold"
            ];
            inactiveBorderColor = [ "#${theme.base0B}" ];
            searchingActiveBorderColor = [
              "#${theme.base0A}"
              "bold"
            ];
            optionsTextColor = [ "#${theme.base0C}" ];
            selectedLineBgColor = [ "#283457" ]; # This is a rose-pine color.
            cherryPickedCommitFgColor = [ "#${theme.base0C}" ];
            cherryPickedCommitBgColor = [ "#${theme.base0D}" ];
            markedBaseCommitFgColor = [ "#${theme.base0C}" ];
            markedBaseCommitBgColor = [ "#${theme.base09}" ];
            unstagedChangesColor = [ "#${theme.base08}" ];
            defaultFgColor = [ "#${theme.base05}" ];
          };
        };
      };
    };
  };

  programs.zsh.initContent =
    let
      zshLazyGitFunc =
        lib.mkOrder 500 # bash
          ''
            lg()
            {
                export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

                lazygit "$@"

                if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
                        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
                        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
                fi
            }

          '';
    in
    lib.mkMerge [ zshLazyGitFunc ];
}
