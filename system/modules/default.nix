{
  imports = [
    ./cleanup.nix
    ./compileopts.nix
    ./displaymanager.nix
    ./fonts.nix
    ./graphics.nix
    ./hyprland.nix
    ./networking.nix
    ./security.nix
    # ./sound.nix # comment this out if using in VM
    # Otherwise the sound in host will stop working
    ./usersettings.nix
  ];
}
