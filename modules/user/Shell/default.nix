{
  imports = [
    ./bat.nix
    ./fzf.nix
    ./nushell.nix
    ./readline.nix
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
    # ./zsh.nix
  ];
  # It's for unstable of 25.11
  home = {
    shell = {
      enableNushellIntegration = true;
    };
  };

  programs = {
    nix-index = {
      enable = true;
    };

    fd = {
      enable = true;
      hidden = true;
    };

    carapace = {
      enable = true;
    };
  };
}
