{
  imports = [
    ./hyprland.nix
    ./mpv.nix
    ./qutebrowser.nix
    # ./unstablepkgs.nix # Not needed if nixpkgs.url = "<some unstable nixos channel>". See flake.nix first
    ./waybar.nix
    ./yazi.nix
  ];
}
