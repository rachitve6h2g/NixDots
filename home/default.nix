{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./Programs
    ./Desktop
  ];
  home = {
    username = "chris";
    homeDirectory = "/home/chris";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

  stylix = {
    enable = true;
    autoEnable = true;

    fonts = {
      monospace = {
        name = "Iosevka Nerd Font Mono";
        package = (pkgs.nerdfonts.override {fonts = [ "Iosevka" ]; });
      };
    };
  };
}
