{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.ironbar.homeManagerModules.default ];

  programs = {
    ironbar = {
      enable = true;
      systemd = true;
      package = pkgs.ironbar;

      # config = {
      #   monitors = {
      #     eDP-1 = {
      #       anchor_to_edges = true;
      #       position = "bottom";
      #       height = 16;
      #       start = [
      #         { type = "clock"; }
      #       ];

      #       end = [
      #         {
      #           type = "upower";
      #           format = "{percentage}";
      #         }
      #       ];
      #     };
      #   };
      # };
    };
  };
}
