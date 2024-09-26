{ 
inputs,
pkgs,
... 
}: {
  programs = {
    dconf.enable = true;

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      systemd.setPath.enable = true;
    };
    
    # sway = {
    #   enable = true;
    #   package = pkgs.sway;
    #   extraPackages = [ ];
    # };

    # Enable the android-debug-bridge
    adb.enable = true; # User must be added to the "adbusers" group
  };

}