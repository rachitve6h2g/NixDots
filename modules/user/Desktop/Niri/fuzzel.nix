{
  lib,
  pkgs,
  ...
}:
let
  app2unit = (
    pkgs.stdenv.mkDerivation {

      pname = "app2unit";
      version = "v0.9.0";

      src = pkgs.fetchFromGitHub {
        owner = "Vladimir-csp";
        repo = "app2unit";
        rev = "a9092d17986b2a23d549a97cc7cdaaf0f7b697f4";
        hash = "sha256-Gd2BCV+7u52EoeVucirKAQfFHzNu13LBz0pHJaFzih0=";
      };

      installPhase = ''
        mkdir -p $out/bin
        cp -r $src/app2* $out/bin/
      '';
    }
  );
in
{

  home.packages = [ app2unit ];
  programs = {
    fuzzel = {
      enable = true;

      settings = {
        main = {
          terminal = "${app2unit}/bin/app2unit -T";
          font = lib.mkForce "monospace:size=11";
          placeholder = "  Enter App Name";
          prompt = "󱡴  ";
          use-bold = "yes";
          layer = "overlay";
          launch-prefix = "${app2unit}/bin/app2unit --fuzzel-compat --";
        };
      };
    };
  };
}
