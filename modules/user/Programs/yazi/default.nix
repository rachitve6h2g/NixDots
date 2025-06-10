{ pkgs, ... }:
{
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";

      flavors = {
        rose-pine = (
          pkgs.stdenv.mkDerivation {
            name = "yazi-rose-pine";
            src = pkgs.fetchFromGitHub {
              owner = "Msouza91";
              repo = "rose-pine.yazi";
              rev = "4101d0d9c475f23d94b7262e7fd945930378807e";
              hash = "sha256-Ygx3tyefGcq3Qqk/72RSJbT5K8G7wVqIk2rCI0vKkNQ=";
            };

            installPhase = ''
              mkdir -p $out
              cp -r $src/* $out/
              mv $out/theme.toml $out/flavor.toml
            '';
          }
        );
      };

      theme = {
        flavor = {
          dark = "rose-pine";
          light = "rose-pine";
        };
      };

      # initLua = builtins.readFile ./init.lua;
    };
  };
}
