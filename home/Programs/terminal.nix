{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    # Fonts are managed by stylix
    # Do not set the fonts here
    # But if you need use
    # lib.mkDefault or lib.mkForce
    font = {
      name = "Iosevka Nerd Font";
      package = pkgs.nerd-fonts.iosevka;
      size = 11.7;
    };

    themeFile = "Catppuccin-Mocha";

    # General settings
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      # Background opacity set here
      background_opacity = 0.7;

      # blur it bro
      background_blur = 4;
    };
  };
}
