{
  imports = [
    ./beets.nix
    ./mpv.nix
    ./music.nix
  ];

  services = {
    playerctld.enable = true;
  };
}
