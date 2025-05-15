{pkgs, ...}: {
  programs = {
    qutebrowser = {
      enable = true;

      settings = {
        tabs = {
          background = true;
          favicons.scale = 1.0;
        };
        window.transparent = true;
        downloads.position = "bottom";
        colors.webpage = {
          preferred_color_scheme = "dark";
          darkmode = {
            enabled = true;
            policy.images = "never";
          };
        };

        content.autoplay = false;

        content.blocking = {
          enabled = true;
          method = "both";
          adblock.lists = [
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-general.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-mobile.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/lan-block.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
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
        rgba2hex = "https://rgbacolorpicker.com/rgba-to-hex";

        # PhysicsWallah
        pw = "https://www.pw.live/";
      };

      # Searchengines
      searchEngines = {
        chatgpt = "https://chat.openai.com/?q={}";
        wa = "https://wiki.archlinux.org/?search={}";
        yt = "https://www.youtube.com/results?search_query={}";
        mynixos = "https://mynixos.com/search?q={}";
        nixpackages = "https://search.nixos.org/packages?query={}";
        nixoptions = "https://search.nixos.org/options?query={}";
      };

      keyBindings = {
        normal = {
          "<ctrl-v>" = "hint links spawn ${pkgs.mpv}/bin/mpv {hint-url}";
          "<ctrl-shift-v>" = "spawn ${pkgs.mpv}/bin/mpv {url}";
        };
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
