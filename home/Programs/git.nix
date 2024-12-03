{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    git-crypt
    git-filter-repo
  ];

  programs = {
    git = {
      enable = true;
      userEmail = "rachitverma1122@gmail.com";
      userName = "rachitve6h2g";
      ignores = [
        ".ssh/id_*"
        "*.pem"
        ".gnupg/"
        "*.gpg"
        "*.asc"
        "*.gpg~"
        "*.asc~"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
        push.autoSetupRemote = true;
      };
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      hashKnownHosts = true;
      userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts";

      extraConfig = ''
        Host github.com
        IdentityFile ~/.ssh/id_ed25519
      '';
    };

    # GPG for signing the ssh keys
    gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.gnupg";
    };
  };

  # Always see that these keys are in gitignore before
  # pushing them to github.
  # home.file = {
  #   ".ssh/id_ed25519".source = ./dangerSshKeys/id_ed25519;
  #   ".ssh/id_ed25519.pub".source = ./dangerSshKeys/id_ed25519.pub;
  # };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry;
      enableSshSupport = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    ssh-agent = {
      enable = true;
    };
  };
}
