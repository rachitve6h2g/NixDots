{ pkgs, ... }:
let
  rose-pine-starship = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/starship/refs/heads/main/rose-pine.toml";
      hash = "sha256-0nK3gRQDuoH+jAvKWbM04rVUXtFNRgvB86jKhuvnr9g=";
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
