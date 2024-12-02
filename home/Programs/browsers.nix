{pkgs, ...}: {
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      nativeMessagingHosts = with pkgs; [
        uget-integrator
      ];
      profiles.chris = {
        name = "Chris";
        id = 0;
        isDefault = true;
        settings = {
          "network.http.http3.enable" = false;
          "browser.startup.homepage" = "https://mynixos.com/";
        };
        search = {
          force = true;
          default = "DuckDuckGo";
          engines = {
            "Nix Store" = {
              urls = [
                {
                  template = "https://mynixos.com/";
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
            };
          };
        };

        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "Reddit";
                url = "https://www.reddit.com/";
              }
              {
                name = "NixOS Discourse";
                url = "https://discourse.nixos.org/";
              }
              {
                name = "Christian Forums";
                url = "https://www.christianforums.com/";
              }
              {
                name = "store";
                url = "https://mynixos.com/";
              }
              {
                name = "homedix";
                url = "https://nix-community.github.io/home-manager/options.xhtml";
              }
              {
                name = "sysdix";
                url = "https://nixos.org/manual/nixos/stable/options";
              }
              {
                name = "WhatsApp";
                url = "https://web.whatsapp.com/";
              }
            ];
          }
        ];
      };
    };
  };
}
