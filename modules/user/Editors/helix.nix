{ lib, pkgs, ... }:
{
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {

        keys = {
        };

        editor = {
          line-number = "relative";

          lsp = {
            display-messages = true;
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
          }
        ];
      };
    };
  };
}
