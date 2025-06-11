{ inputs, pkgs, ... }:
{
  imports = [ inputs.battery-notifier.homeManagerModule.default ];

  services.battery-notifier = {
    enable = true;
    settings = {
      icon_path = "${pkgs.rose-pine-icon-theme}/share/icons/rose-pine";
      interval_ms = 700;
      reminder = {
        threshold = 40;
        title = "Battery Low";
        content = "Battery Capacity is at \${{capacity}}%.\nConsider plugging in your laptop to avoid running out of power.";
      };

      warn = {
        threshold = 30;
        title = "Battery Very Low";
        content = "Battery about to die.";
      };

      threat = {
        threshold = 25;
        title = "Battery Super Duper Low!!";
        content = "Get the charger you lazy dawg!!\nYou kill me, you die!";
      };
    };
  };
}
