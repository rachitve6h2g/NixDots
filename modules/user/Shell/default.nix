{
  imports = [
    ./bat.nix
    ./fzf.nix
    # ./nushell.nix
    ./readline.nix
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];
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
