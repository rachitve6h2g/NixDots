{ lib, ... }:
{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };

        sugarCandyNix = {
          enable = true;
          settings = {
            HeaderText = "Welcome, Krish!";
            DimBackgroundImage = 0.3;
            Background = lib.cleanSource ./../../wallpapers/current;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "left";
            HaveFormBackground = true;
            PartialBlur = true;
            Font = "JetBrainsMono Nerd Font";
          };
        };
      };
    };
  };
}
