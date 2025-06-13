{ pkgs, ... }:
let
  rose-pine-starship = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/starship/refs/heads/main/rose-pine-moon.toml";
      hash = "sha256-otDEoVh1WGRsQmWMmJPekqPWwcX3REm9TjTF13vXnGw=";
    }
  );
in
{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  xdg.configFile."starship.toml".source = rose-pine-starship;
}
