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
        DisableBuiltinPDFViewer = true;
        DisableFirefoxStudies = true;
        DisableFirefoxScreenshots = true;
        DisableFormHistory = true;
        DisablePocket = true;
        DisableSetDesktopBackground = true;
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };

        ExtensionUpdate = true;
        HardwareAcceleration = true;
        PDFjs = {
          Enabled = false;
          EnablePermissions = false;
        };

        Permissions = {
          Camera = {
            Allow = [ ];
            BlockNewRequests = true;
            Locked = true;
          };

          Microphone = {
            Allow = [ ];
            BlockNewRequests = true;
            Locked = true;
          };
          Location = {
            Allow = [ ];
            BlockNewRequests = true;
            Locked = true;
          };
        };
      };

      profiles = {
        krish = {
          isDefault = true;

          search = {
            force = true;

            default = "ddg";
            privateDefault = "ddg";

            engines = {
              nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                definedAliases = [ "@nw" ];
              };

              nix-packages = {
                name = "Nix Packages";
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              home-manager-options = {
                name = "Home Manager Options";
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                      {
                        name = "release";
                        value = "master";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hmopts" ];
              };

              mynixos = {
                name = "MyNixOS";
                urls = [
                  {
                    template = "https://mynixos.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

                definedAliases = [ "@mynixos" ];
              };

              bing.metaData.hidden = true;
              google.metaData.alias = "@g";
            };
          };
          settings = {
            "extensions.autoDisableScopes" = 0; # This will automatically enable installed extensions
            "browser.startup.homepage" = "https://www.startpage.com/";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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

              "uBlock0@raymondhill.net" = {
                force = true;
                settings = {
                  selectedFilterLists = [
                    "ublock-filters"
                    "ublock-badware"
                    "ublock-privacy"
                    "ublock-unbreak"
                    "ublock-quick-fixes"
                  ];
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
