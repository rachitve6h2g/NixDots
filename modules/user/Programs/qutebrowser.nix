{ pkgs, config, ... }:
let
  theme = config.colorScheme.palette;
in
{
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
        colors = {
          webpage = {
            preferred_color_scheme = "dark";
            darkmode = {
              enabled = true;
              policy.images = "never";
            };
          };
          completion = {
            fg = "#${theme.base05}";
            odd.bg = "#${theme.base01}";
            even.bg = "#${theme.base00}";
            category = {
              fg = "#${theme.base0A}";
              bg = "#${theme.base00}";
              border = {
                top = "#${theme.base00}";
                bottom = "#${theme.base00}";
              };
            };
            item = {
              selected = {
                fg = "#${theme.base05}";
                bg = "#${theme.base02}";
                border = {
                  top = "#${theme.base02}";
                  bottom = "#${theme.base02}";
                };
                match.fg = "#${theme.base0B}";
              };
            };
            match.fg = "#${theme.base0B}";
            scrollbar = {
              fg = "#${theme.base05}";
              bg = "#${theme.base00}";
            };
          };
          contextmenu = {
            disabled = {
              bg = "#${theme.base01}";
              fg = "#${theme.base04}";
            };
            menu = {
              bg = "#${theme.base00}";
              fg = "#${theme.base05}";
            };
            selected = {
              bg = "#${theme.base02}";
              fg = "#${theme.base05}";
            };
          };

          downloads = {
            bar.bg = "#${theme.base00}";
            start = {
              fg = "#${theme.base00}";
              bg = "#${theme.base0D}";
            };

            stop = {
              fg = "#${theme.base00}";
              bg = "#${theme.base0C}";
            };
            error.fg = "#${theme.base08}";
          };

          hints = {
            fg = "#${theme.base00}";
            bg = "#${theme.base0A}";

            match = {
              fg = "#${theme.base05}";
            };
          };
          keyhint = {
            fg = "#${theme.base05}";
            bg = "#${theme.base00}";
            suffix.fg = "#${theme.base05}";
          };
          messages = {
            error = {
              fg = "#${theme.base00}";
              bg = "#${theme.base08}";
              border = "#${theme.base08}";
            };
            warning = {
              fg = "#${theme.base00}";
              bg = "#${theme.base0E}";
              border = "#${theme.base0E}";
            };
            info = {
              fg = "#${theme.base05}";
              bg = "#${theme.base00}";
              border = "#${theme.base00}";
            };
          };

          prompts = {
            fg = "#${theme.base05}";
            bg = "#${theme.base00}";
            border = "#${theme.base00}";
            selected = {
              bg = "#${theme.base02}";
              fg = "#${theme.base05}";
            };
          };

          statusbar = {
            normal = {
              fg = "#${theme.base0B}";
              bg = "#${theme.base00}";
            };
            insert = {
              fg = "#${theme.base00}";
              bg = "#${theme.base0D}";
            };
            passthrough = {
              fg = "#${theme.base00}";
              bg = "#${theme.base0C}";
            };

            private = {
              fg = "#${theme.base00}";
              bg = "#${theme.base05}";
            };
            command = {
              fg = "#${theme.base05}";
              bg = "#${theme.base00}";
              private = {
                fg = "#${theme.base05}";
                bg = "#${theme.base00}";
              };
            };
            caret = {
              fg = "#${theme.base00}";
              bg = "#${theme.base0E}";
              selection = {
                fg = "#${theme.base00}";
                bg = "#${theme.base0D}";
              };
            };

            progress = {
              bg = "#${theme.base0D}";
            };

            url = {
              fg = "#${theme.base05}";
              error.fg = "#${theme.base08}";
              hover.fg = "#${theme.base05}";
              success = {
                http.fg = "#${theme.base0C}";
                https.fg = "#${theme.base0B}";
              };
              warn.fg = "#${theme.base0E}";
            };
          };

          tabs = {
            bar.bg = "#${theme.base00}";
            indicator = {
              start = "#${theme.base0D}";
              stop = "#${theme.base0C}";
              error = "#${theme.base08}";
            };
            odd = {
              fg = "#${theme.base05}";
              bg = "#${theme.base01}";
            };
            even = {
              fg = "#${theme.base05}";
              bg = "#${theme.base00}";
            };

            pinned = {
              even = {
                bg = "#${theme.base0C}";
                fg = "#${theme.base07}";
              };
              odd = {
                bg = "#${theme.base0B}";
                fg = "#${theme.base07}";
              };
              selected = {
                even = {
                  bg = "#${theme.base02}";
                  fg = "#${theme.base05}";
                };
                odd = {
                  bg = "#${theme.base02}";
                  fg = "#${theme.base05}";
                };
              };
            };
            selected = {
              odd = {
                fg = "#${theme.base05}";
                bg = "#${theme.base02}";
              };
              even = {
                fg = "#${theme.base05}";
                bg = "#${theme.base02}";
              };
            };
          };
        };

        content.autoplay = false;

        content = {
          blocking = {
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
      };

      # TODO: Add stuff here
      quickmarks = {
        # Options for NixOS
        nixconfig = "https://nixos.org/manual/nixos/stable/options.html";
        nixdisco = "https://discourse.nixos.org/";

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
        nixpackages = "https://search.nixos.org/packages?channel=25.05&query={}";
        nixoptions = "https://search.nixos.org/options?query={}";
        g = "https://www.google.co.in/search?q={}";
        github = "https://www.github.com/search?q={}";
        home-manager = "https://home-manager-options.extranix.com/?query={}&release=master";
      };

      keyBindings = {
        normal = {
          "<ctrl-v>" = "hint links spawn -ov ${pkgs.mpv}/bin/mpv {hint-url}";
          "<ctrl-shift-v>" = "spawn -ov ${pkgs.mpv}/bin/mpv {url}";
          "ya" = "spawn -vo ${pkgs.mpv}/bin/mpv --force-window --no-video {url}";
          "yA" = "hint links spawn -vo ${pkgs.mpv}/bin/mpv --force-window --no-video {hint-url}";
        };
      };

      # Extras
      # extraConfig =
      #   # python
      #   ''
      #     import os
      #     from urllib.request import urlopen
      #
      #     # load your autoconfig, use this, if the rest of your config is empty!
      #     config.load_autoconfig()
      #
      #     if not os.path.exists(config.configdir / "theme.py"):
      #         theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
      #         with urlopen(theme) as themehtml:
      #             with open(config.configdir / "theme.py", "a") as file:
      #                 file.writelines(themehtml.read().decode("utf-8"))
      #
      #     if os.path.exists(config.configdir / "theme.py"):
      #         import theme
      #         theme.setup(c, 'mocha', True)
      #   '';
    };
  };
}
