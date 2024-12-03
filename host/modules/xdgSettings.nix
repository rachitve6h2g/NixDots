{
  pkgs,
  config,
  ...
}: {
  xdg = {
    icons.enable = true;
    menus.enable = true;

    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"
        ];
      };
    };
  };
}
