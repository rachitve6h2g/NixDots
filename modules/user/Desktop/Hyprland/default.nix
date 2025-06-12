{lib, pkgs, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpolkitagent.nix
    ./waybar.nix

    ./hypr
  ];

  xdg.configFile."uwsm/env-hyprland".source = ./uwsm/env-hyprland;

  home.packages = with pkgs; [ swappy ];

  wayland.windowManager.hyprland = {
    enable = true;
    sourceFirst = true;

    importantPrefixes = [
      "$"
      "bezier"
      "monitor"
      "env"
    ];

    # TODO: Start Hyprland with uwsm
    # And disable these settings accordingly
    systemd = {
      enable = lib.mkForce false;
      #variables = [ "--all" ];
    };
  };
}
