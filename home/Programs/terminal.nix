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
      name = lib.mkForce "Iosevka Nerd Fonts";
      size = lib.mkForce 12;
    };

    # General settings
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      # Anything related to background or appearance is
      # handeled by Stylix
    };
  };

  # the opacity is managed by stylix
  stylix.opacity.terminal = 0.85;
}
