{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    btop = {
      enable = true;
      package = pkgs.btop;

      # Settings defined here
      settings = {
        vim_keys = true;
        color_theme = "catppuccin_mocha";
      };
    };

    zathura = {
      enable = true;
    };

    bat = {
      enable = true;
    };
  };

  xdg.configFile."btop/themes/catppuccin_mocha.theme".text = builtins.readFile "${inputs.btop-catppuccin}/themes/catppuccin_mocha.theme";
}
