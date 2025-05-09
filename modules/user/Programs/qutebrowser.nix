{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser-overlay = prev.qutebrowser.override {
        enableWideVine = true;
        enableVulkan = true;
      };
    })
  ];
  programs = {
    qutebrowser = {
      enable = true;
      pacakge = pkgs.qutebrowser-overlay;

      settings = {
        tabs.background = true;
        downloads.position = "bottom";
        colors.webpage.preferred_color_scheme = "dark";

        content.blocking = {
          method = "both";
          adblock.lists = [
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"
          ];
        };
      };

      # TODO: Add stuff here
      quickmarks = {
        # Options for NixOS
        home-manager = "https://nix-community.github.io/home-manager/options.xhtml";
        nixconfig = "https://nixos.org/manual/nixos/stable/options.html";

        # For Other stuff
        youtube = "https://www.youtube.com/";
        moviesmod = "https://moviesmod.email/";
        reddit = "https://www.reddit.com/";
        letstype = "https://monkeytype.com/";
        letstype2 = "https://www.keybr.com/";
        whatsapp = "https://web.whatsapp.com/";
        nvf = "https://notashelf.github.io/nvf/options.xhtml";
      };

      # Searchengines
      searchEngines = {
        chatgpt = "https://chat.openai.com/?q={}";
        wa = "https://wiki.archlinux.org/?search={}";
        yt = "https://www.youtube.com/results?search_query={}";
        mynixos = "https://mynixos.com/search?q={}";
      };

      # Extras
      extraConfig =
        /*
        python
        */
        ''
          import os
          from urllib.request import urlopen

          # load your autoconfig, use this, if the rest of your config is empty!
          config.load_autoconfig()

          if not os.path.exists(config.configdir / "theme.py"):
              theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
              with urlopen(theme) as themehtml:
                  with open(config.configdir / "theme.py", "a") as file:
                      file.writelines(themehtml.read().decode("utf-8"))

          if os.path.exists(config.configdir / "theme.py"):
              import theme
              theme.setup(c, 'mocha', True)
        '';
    };
  };
}
