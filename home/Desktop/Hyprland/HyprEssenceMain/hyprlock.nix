{
  pkgs,
  config,
  ...
}: let
  theme = config.colorScheme.palette;
  wallpaper2 = "${./../../../../wallpapers/sddm_n_hyprlock}";

  showBattery = pkgs.writeShellScriptBin "showBattery" ''
    battery_percentage=$(${pkgs.coreutils-full}/bin/cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(${pkgs.coreutils-full}/bin/cat /sys/class/power_supply/BAT0/status)
    battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
    charging_icon="󰂄"

    icon_index=$((battery_percentage / 10))

    battery_icon=$(battery_icons[icon_index])

    if [ "$battery_status" = "Charging" ]; then
    	battery_icon="$charging_icon"
    fi

    ${pkgs.coreutils-full}/bin/echo "$battery_percentage% $battery_icon"
  '';
in {
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;

    sourceFirst = true;
    importantPrefixes = [
      "$"
      "monitor"
      "size"
      "source"
    ];

    settings = {
      source = "${./../HyprStuff/mocha.conf}";

      "$accent" = "rgb(${theme.base0E})";
      "$accentAlpha" = "${theme.base0E}";
      "$font" = "Iosevka Nerd Font";

      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = " ";
          path = "${wallpaper2}";
          blur_passes = 0;
          color = "rgb(${theme.base00})";
        }
      ];

      label = [
        # LAYOUT
        {
          monitor = " ";
          text = "Layout: $LAYOUT";
          color = "rgb(${theme.base0F})";
          font_size = 25;
          font_family = "$font";
          position = "30, -30";
          halign = "left";
          valign = "top";
        }
        # TIME
        {
          monitor = " ";
          text = "$TIME12";
          color = "rgb(${theme.base0F})";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }

        # DATE
        {
          monitor = " ";
          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
          color = "rgb(${theme.base0F})";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }

        # BATTERY
        {
          monitor = " ";
          text = "cmd[update:1000] ${pkgs.coreutils-full}/bin/echo -e \"$(${showBattery}/bin/showBattery)\"";
          color = "rgb(${theme.base0F})";
          font_size = 12;
          font_family = "$font";
          position = "-20, -510";
          halign = "right";
          valign = "center";
        }
      ];

      image = [
        # USER AVATAR
        {
          monitor = " ";
          path = "${./../HyprStuff/face}";
          size = 100;
          border_color = "$accent";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = " ";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "rgb(${theme.base02})";
          font_color = "rgb(${theme.base0F})";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##${theme.base0F}\"><i>󰌾 Logged in as </i><span foreground=\"##$accentAlpha\">$USER</span></span>";
          hide_input = false;
          check_color = "$accent";
          fail_color = "rgb(${theme.base08})";
          fail_text = "<i>$FAIL <b>($ATTEMPT)</b></i>";
          capslock_color = "rgb(${theme.base0A})";
          position = "0, -47";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
