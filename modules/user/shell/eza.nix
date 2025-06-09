{ pkgs, ... }:
let
  rose-pine-eza = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/eza-community/eza-themes/refs/heads/main/themes/rose-pine.yml";
      hash = "sha256-P44bk0icBKkySQw17kVkLNGEgI49wav04bf+vJs5dcc=";
    }
  );
in
{
  programs.eza = {
    enable = true;

    enableZshIntegration = true;

    git = true;
    icons = "auto";
    colors = "auto";

    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  # TODO: Replace this with github file.
  xdg.configFile."eza/theme.yml".source = rose-pine-eza;
}
