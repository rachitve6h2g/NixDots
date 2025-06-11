{ inputs, lib, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs = {
    zen-browser = {
      enable = true;

      enableGnomeExtensions = false;

      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };

      profiles = {
        krish = {
          isDefault = true;
          bookmarks = {
            force = true;
            settings = [
              {
                name = "wikipedia";
                tags = [ "wiki" ];
                keyword = "wiki";
                url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
              }

              {
                name = "kernel.org";
                url = "https://www.kernel.org";
              }

              {
                name = "Nix sites";
                toolbar = true;
                bookmarks = [
                  {
                    name = "homepage";
                    url = "https://nixos.org/";
                  }

                  {
                    name = "wiki";
                    tags = [
                      "wiki"
                      "nix"
                    ];
                    url = "https://wiki.nixos.org/";
                  }
                ];
              }
            ];
          };

          userChrome =
            let
              userChrome = ''${builtins.readFile ./userChrome.css}'';
              rose-pine = ''${builtins.readFile ./rose-pine-main.css}'';
            in
            lib.mkMerge [
              rose-pine
              userChrome
            ];
        };
      };
    };
  };
}
