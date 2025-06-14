{
  imports = [
    ./battery.nix
    ./bluetooth.nix
    ./boot-loader.nix
    ./cleanup.nix
    ./compileopts.nix
    ./graphics.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./sound.nix # comment this out if using in VM
    # Otherwise the sound in host will stop working
    ./system.nix
    ./thunar.nix
    ./user.nix
    # ./virtualbox.nix

    ./Desktop
  ];
}
