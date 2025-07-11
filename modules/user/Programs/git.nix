{
  pkgs,
  lib,
  ...
}:
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
