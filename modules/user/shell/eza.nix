{ pkgs, ... }:
let
  rose-pine-eza = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rachitve6h2g/SwayDots/refs/heads/master/eza/.config/eza/rose-pine-eza.yml";
      hash = "sha256-fwhM45rLF3IJVHuFaYPxNrq/HprfF8pKJvu1JxlTbJc=";
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
