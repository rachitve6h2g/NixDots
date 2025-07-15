{
  imports = [
    ./mpv.nix
    ./music.nix
  ];

  services = {
    playerctld.enable = true;
  };
}
