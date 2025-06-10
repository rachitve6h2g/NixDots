{ pkgs, ... }:
{
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";

      flavors = {
        catppuccin-mocha = (
          pkgs.stdenv.mkDerivation {
            name = "catppuccin-mocha-yazi";
            src = pkgs.fetchFromGitHub {
              owner = "yazi-rs";
              repo = "flavors";
              rev = "d04a298a8d4ada755816cb1a8cfb74dd46ef7124";
              hash = "sha256-m3yk6OcJ9vbCwtxkMRVUDhMMTOwaBFlqWDxGqX2Kyvc=";
            };

            installPhase = ''
              mkdir -p $out
              cp -r $src/catppuccin-mocha.yazi/* $out/
            '';
          }
        );
      };

      theme = {
        flavor = {
          dark = "catppuccin-mocha";
          light = "catppuccin-mocha";
        };
      };

      # initLua = builtins.readFile ./init.lua;
    };
  };
}
