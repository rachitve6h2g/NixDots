{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./Programs
    ./Desktop

    ./stylesHome.nix
    ./xdgSettings.nix
  ];
  home = {
    username = "chris";
    homeDirectory = "/home/chris";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
