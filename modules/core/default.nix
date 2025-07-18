{
  imports = [
    ./battery.nix
    ./bluetooth.nix
    ./boot-loader.nix
    ./cleanup.nix
    ./compileopts.nix
    ./consoleKeymap.nix
    ./graphics.nix
    ./keymap.nix
    ./networking.nix
    ./nh.nix
    ./nix.nix
    ./nix-index.nix
    ./plymouth.nix
    ./security.nix
    ./sound.nix # comment this out if using in VM
    # Otherwise the sound in host will stop working
    ./stylix.nix
    ./system.nix
    ./thunar.nix
    ./user.nix
    # ./virtualbox.nix
    ./vivid.nix
    ./zram.nix

    ./Desktop
  ];
}
