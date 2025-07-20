{
  pkgs,
  ...
}:
{
  imports = [
    ./github-cli.nix
    ./lazygit.nix
  ];

  programs = {
    git = {
      enable = true;

      package = pkgs.git.override { withLibsecret = true; };

      userName = "Rachit Kumar Verma";
      userEmail = "rachitverma1122@gmail.com";

      delta = {
        enable = true;
        options = {
          navigate = true;
          dark = true;
          side-by-side = true;
          hyperlinks = true;
          line-numbers = true;
        };
      };

      aliases = {
        co = "checkout";
        s = "status";
        ss = "status --short --branch";
        ci = "commit";
      };

      # signing = {
      #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERLusf6Vosz5TB5uTmnunxK0pW1CaaKdpEsXIpyXhq+";
      #   signByDefault = true;
      # };

      # extraConfig = {
      #   credential.helper = "libsecret";

      #   push = {
      #     autoSetupRemote = true;
      #   };

      #   # Sign all commits using ssh key
      #   commit.gpgsign = true;
      #   gpg = {
      #     format = "ssh";
      #   };

      #   merge = {
      #     conflictstyle = "zdiff3";
      #   };
      # };
    };

    ssh = {
      enable = true;
      hashKnownHosts = true;
      addKeysToAgent = "yes";
    };
  };
}
