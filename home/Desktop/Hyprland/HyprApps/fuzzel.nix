{
  pkgs,
  lib,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;

    # General settings
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
      };

      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "bac2deff";
        placeholder = "7f849cff";
        input = "cdd6f4ff";
        match = "cba6f7ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "cba6f7ff";
        counter = "7f849cff";
        border = "cba6f7ff";
      };
    };
  };
}
