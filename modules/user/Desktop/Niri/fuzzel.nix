{
  config,
  pkgs,
  ...
}:
let
  theme = config.colorScheme.palette;

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
          font = "monospace:size=11";
          placeholder = "Enter App Name";
          prompt = "󱡴 ";
          use-bold = "yes";
          # icon-theme = "${pkgs.rose-pine-icon-theme}/share/icons/rose-pine";
          icon-theme = "rose-pine";
          layer = "overlay";
          launch-prefix = "${app2unit}/bin/app2unit --fuzzel-compat --";
        };

        colors = {
          background = "#${theme.base00}dd";
          text = "#${theme.base05}ff";
          prompt = "#${theme.base0D}ff";
          placeholder = "#${theme.base03}ff";
          input = "#${theme.base05}ff";
          match = "#${theme.base0A}ff";
          selection = "#${theme.base0F}ff";
          selection-text = "#${theme.base06}ff";
          selection-match = "#${theme.base0A}ff";
          counter = "#${theme.base0F}ff";
          border = "#${theme.base0A}ff";
        };
      };
    };
  };
}
