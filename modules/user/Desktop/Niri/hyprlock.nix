{
  config,
  pkgs,
  ...
}: let
  rose-pine-scenery = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/fr0st-iwnl/wallz/refs/heads/main/Ros%C3%A9%20Pine/19.%20Ros%C3%A9%20Pine.jpeg";
      hash = "sha256-8Zq7QzqlLswgilV6sOGBgcl+8L6XURYwxIh8FLz+1s0=";
    }
  );

  myTheme = config.colorScheme.palette;

  batStatus = pkgs.writeShellScriptBin "batStatus" ''
    enable_battery=false
    battery_charging=false

    for battery in /sys/class/power_supply/*BAT*; do
      if [[ -f "$battery/uevent" ]]; then
        enable_battery=true
        if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
          battery_charging=true
        fi
        break
      fi
    done

    if [[ $enable_battery == true ]]; then
      if [[ $battery_charging == true ]]; then
       echo -n "(+) "
      fi
      echo -n "$(cat /sys/class/power_supply/*/capacity | head -1)"%
      if [[ $battery_charging == false ]]; then
        echo -n " remaining"
      fi
    fi
  '';
in {
  programs = {
    hyprlock = {
      enable = true;

      settings = let
        text_color = "rgba(${myTheme.base05}ff)";
        entry_background_color = "rgba(${myTheme.base02}11)";
        entry_border_color = "rgba(${myTheme.base0D}55)";
        entry_color = "rgba(FFFFFFFF)";
        font_family = "monospace";
        font_family_clock = font_family;
        font_material_symbols = font_family;
      in {
        animations = [
          {
            enabled = true;
            bezier = "linear, 1, 1, 0, 0";
            animation = "fade, 1, 1.8, linear";
          }
        ];

        background = [
          {
            color = "rgba(000000FF)";
            path = "${rose-pine-scenery}";
            blur_size = 3;
            blur_passes = 1;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "250, 50";
            outline_thickness = 2;
            dots_size = 0.1;
            dots_spacing = 0.3;
            outer_color = entry_border_color;
            inner_color = entry_background_color;
            font_color = entry_color;
            fade_on_empty = true;

            position = "0, -15";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = "$TIME12";
            shadow_passes = 1;
            shadow_boost = 0.5;
            color = text_color;
            font_size = 65;
            font_family = font_family_clock;

            position = "0, 300";
            halign = "center";
            valign = "center";
          }

          {
            monitor = "";
            text = "hi $USER!!!";
            shadow_passes = 1;
            shadow_boost = 0.5;
            color = text_color;
            font_size = 20;
            font_family = font_family;

            position = "0, 240";
            halign = "center";
            valign = "center";
          }

          {
            monitor = "";
            text = "\"Main Itna Bhi Kuch Khaas Nahi\"";
            shadow_passes = 1;
            shadow_boost = 0.5;
            color = text_color;
            font_size = 21;
            font_family = font_material_symbols;

            position = "0, 65";
            halign = "center";
            valign = "bottom";
          }

          {
            monitor = "";
            text = "-Shin Chan";
            shadow_passes = 1;
            shadow_boost = 0.5;
            color = text_color;
            font_size = 14;
            font_family = font_family;

            position = "0, 45";
            halign = "center";
            valign = "bottom";
          }

          {
            monitor = "";
            text = "cmd[update:5000] ${batStatus}/bin/batStatus";
            shadow_passes = 1;
            shadow_boost = 0.5;
            color = text_color;
            font_size = 14;
            font_family = font_family;

            position = "30, -30";
            halign = "left";
            valign = "top";
          }
        ];

        image = [
          {
            monitor = " ";
            path = "${./face}";
            size = 100;
            border_color = "rgb(${myTheme.base0A})";
            position = "0, 75";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
