{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  theme = config.colorScheme.palette;
in
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

          settings = {
            "extensions.autoDisableScopes" = 0; # This will automatically enable installed extensions
          };

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
          extensions = {
            force = true;

            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              darkreader
              localcdn
              stylus
              ublock-origin
            ];

            settings = {
              "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
                force = true;
                settings = {
                  dbInChromeStorage = true;
                };
              };
            };
          };

          userChrome =
            let
              userChrome = ''${builtins.readFile ./userChrome.css}'';
              rose-pine = # css
                ''
                  * {
                    --base: #${theme.base00};
                    --surface: #${theme.base01};
                    --overlay: #${theme.base02};
                    --muted: #${theme.base03};
                    --subtle: #${theme.base04};
                    --text: #${theme.base05};
                    --love: #${theme.base08};
                    --gold: #${theme.base09};
                    --rose: #${theme.base0A};
                    --pine: #${theme.base0B};
                    --foam: #${theme.base0C};
                    --iris: #${theme.base0D};
                    --highlightLow: #2a283e;
                    --highlightMed: #44415a;
                    --highlightHigh: #${theme.base0F};
                  }
                '';
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
