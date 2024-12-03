{
  pkgs,
  lib,
  ...
}: {
  # Disable stylix for kitty
  stylix.targets.kitty.enable = false;

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
      name = lib.mkForce "Iosevka Nerd Fonts";
      package = lib.mkForce pkgs.nerd-fonts.iosevka;
      size = lib.mkForce 13;
    };

    themeFile = "Catppuccin-Mocha";

    # General settings
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      # Background opacity set here
      background_opacity = 0.8;

      # blur it bro
      background_blur = 4;
    };
  };
}
