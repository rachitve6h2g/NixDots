{
  inputs,
  pkgs,
  ...
}:
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

        # If not available in NUR.
        ExtensionSettings = {
          # Unhook, YouTube suggestions removed.
          "myallychou@gmail.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4263531/youtube_recommended_videos-1.6.7.xpi";
            installation_mode = "force_installed";
            private_browsing = "true";
          };
        };

        # about:config settings defined globally
        Preferences = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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

              archwiki = {
                name = "ArchWiki";
                urls = [
                  {
                    template = "https://wiki.archlinux.org/index.php";
                    params = [
                      {
                        name = "search";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "https://archlinux.org/static/logos/legacy/arch-legacy-blue2.svg";
                definedAliases = [ "@alwiki" ];
              };

              gentoowiki = {
                name = "Gentoo Wiki";
                urls = [
                  {
                    template = "https://wiki.gentoo.org/index.php";
                    params = [
                      {
                        name = "search";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                iconMapObj."16" = "https://wiki.gentoo.org/images/d/dd/Genchu.png";
                definedAliases = [ "@gwiki" ];
              };

              gitrepos = {
                name = "Git Repos";
                urls = [
                  {
                    template = "https://github.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                      {
                        name = "type";
                        value = "repositories";
                      }
                    ];
                  }
                ];
                iconMapObj."16" = "https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png";
                definedAliases = [ "@gitrepo" ];
              };

              chatgpt = {
                name = "ChatGpt";
                urls = [
                  {
                    template = "https://chat.openai.com/?q={searchTerms}";
                  }
                ];

                iconMapObj."16" = "https://chat.openai.com/favicon.ico";
                definedAliases = [ "@gpt" ];
              };

              bing.metaData.hidden = true;
              google.metaData.alias = "@g";
            };
          };
          settings = {
            "extensions.autoDisableScopes" = 0; # This will automatically enable installed extensions
            "webgl.disabled" = false;
            # "privacy.resistFingerprinting" = false;
            # "privacy.clearOnShutdown.history" = false;
            # "privacy.clearOnShutdown.cookies" = false;
            # "network.cookie.lifetimePolicy" = 0;
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
              facebook-container
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
        };
      };
    };
  };

  # Zen stylix module:
  stylix.targets.zen-browser.profileNames = [ "krish" ];
}
